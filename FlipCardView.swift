//
//  FlipCardView.swift
//  Drinking game
//
//  Created by 是她 on 24/9/2025.
//

import Foundation
import SwiftUI

struct FlipCardView<Back :View, Front : View> : View {
    @State private var angle: Double = 0
    @State private var isFrontVisible: Bool = false
    
    let back: () -> Back
    let front: () -> Front
    var flipDuration : Double = 0.6
    
    var body: some View {
        ZStack{
            back()
                .opacity(isFrontVisible ? 0 : 1)
                .rotation3DEffect(.degrees(angle), axis: (x:0 ,y: 1 , z:0))
            front()
                .opacity(isFrontVisible ? 1 : 0)
                .rotation3DEffect(.degrees(angle + 180), axis: (x:0 ,y: 1 , z:0))
        }
        .animation(.easeInOut(duration: flipDuration), value: angle)
        .accessibilityHidden(true)
    }
    func flip(toFront: Bool){
        guard isFrontVisible != toFront else { return }
        withAnimation(.easeIn(duration:flipDuration/2)){angle = 90}
        
        DispatchQueue.main.asyncAfter(deadline: .now() + flipDuration/2) {
            isFrontVisible = toFront
            withAnimation(.easeOut(duration: flipDuration/2)){angle = 180}
        }
    }
}


