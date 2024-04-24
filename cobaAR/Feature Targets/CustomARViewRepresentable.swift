//
//  CustomARViewRepresentable.swift
//  cobaAR
//
//  Created by Brendan Alexander Soendjojo on 25/04/24.
//

import SwiftUI

struct CustomARViewRepresentable: UIViewRepresentable {
    
    func makeUIView(context: Context) -> CustomARView {
        return CustomARView()
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {
        // for later user
    }
}
