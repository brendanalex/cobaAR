//
//  CustomARView.swift
//  cobaAR
//
//  Created by Brendan Alexander Soendjojo on 24/04/24.
//

import ARKit
import RealityKit
import SwiftUI
//import PlaygroundSupport

class CustomARView: ARView {
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    
    dynamic required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // This is the init that is actually used
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        bee()
    }
    
    func configurationExamples() {
        // Tracks the device relative to it's environment
        let configuration = ARWorldTrackingConfiguration()
        session.run(configuration)
        
        // OTHER TYPES OF CONFIGURATION:
        // Tracks global coordinates
        let _ = ARGeoTrackingConfiguration()
        
        // Tracks faces in the scene
        let _ = ARFaceTrackingConfiguration()
        
        // Tracks bodies in the scene
        let _ = ARBodyTrackingConfiguration()
    }
    
    func anchorExamples() {
        // Attach anchors at specific coordinates in the iphone-centered coordinate system
        // .zero means placing the anchor on coordinate (0,0,0) exactly where the iphone started
        let coordinateAnchor = AnchorEntity(world: .zero)
        
        // Attach anchors to detected planes
        let _ = AnchorEntity(plane: .horizontal)
        let _ = AnchorEntity(plane: .vertical)
        
        // Attach anchors to a detected face
        let _ = AnchorEntity(.face)
        
        // Attach anchors to tracked images, like markers
        let _ = AnchorEntity(.image(group: "group", name: "name"))
        
        // Add an anchor to the scene
        scene.addAnchor(coordinateAnchor)
    }
    
    func entityExamples() {
        // Load an entity from a usdz file
        let _ = try? Entity.load(named: "usdzfilename")
        
        // Load an entity from reality file
        let _ = try? Entity.load(named: "realityFileName")
        
        // Generate an entity with code
        let box = MeshResource.generateBox(size: 1)
        let entity = ModelEntity(mesh: box)
        
        // Add entity to an anchor, so it's placed in the scene
        let anchor = AnchorEntity()
        anchor.addChild(entity)
    }
    
    func placeBlueBlock(){
        let block = MeshResource.generateBox(size: 1)
        let material = SimpleMaterial(color: .blue, isMetallic: false)
        let entity = ModelEntity(mesh: block, materials: [material])
        
        let anchor = AnchorEntity(plane: .horizontal)
        anchor.addChild(entity)
        
        scene.addAnchor(anchor)
    }
    
    func bee(){
        
        // Load Bee USDZ file
        let bee = try! Entity.load(named: "Microsoft_Bee")
        
        // Scale the bee to a smaller size and move it back
        bee.scale = SIMD3<Float>(repeating: 0.001)
        bee.transform.translation = SIMD3<Float>(x: 0, y: 3, z: -2.0)
        
        // Make an anchor and add a child entity to that anchor
        let anchor = AnchorEntity(plane: .horizontal)
        anchor.addChild(bee)
        
        scene.addAnchor(anchor)
        
        for anim in bee.availableAnimations {
            bee.playAnimation(anim.repeat(duration: .infinity), transitionDuration: 1.25, startsPaused: false)
        }
    }
}
