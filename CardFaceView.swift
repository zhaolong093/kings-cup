//
//  CardFaceView.swift
//  Drinking game
//
//  Created by 是她 on 24/9/2025.
//

import SwiftUI

struct CardFaceView: View {
    let title: String
    let subtitle : String?
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .shadow(radius: 5)
            
            VStack(spacing: 8){
                Text(title)
                    .font(.system(size:56, weight: .bold, design: .rounded))
                if let subtitle{
                    Text(subtitle)
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
            }
            .padding()
        }
        .frame(height: 260)
    }
}

struct CardBackView: View{
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .fill(LinearGradient(colors: [.blue.opacity(0.8), .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                .shadow(radius: 5)
            
            Image(systemName: "suit.clubs.fill")
                .font(.system(size: 64, weight: .semibold))
                .foregroundStyle(.white.opacity(0.9))
        }
        .frame(height: 260)
    }
}
