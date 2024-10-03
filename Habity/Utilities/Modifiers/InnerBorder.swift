//
//  InnerBorder.swift
//  Next
//
//  Created by jalal on 5/5/24.
//

import Foundation
import SwiftUI

struct InnerBorder: ViewModifier {
    
    @State var capsuleStyle = false
    @State var border = 2.0
    @State var borderColor = Color.white
    @State var opacity = 0.2
    
    func body(content: Content) -> some View {
        
        if !capsuleStyle {
            content
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .strokeBorder(borderColor, lineWidth: border)
                        .opacity(opacity)
                }
        } else {
            content
                .clipShape(Capsule(style: .continuous))
                .overlay {
                    Capsule(style: .continuous)
                        .strokeBorder(borderColor, lineWidth: border)
                        .opacity(opacity)
                }
        }
    }
}
