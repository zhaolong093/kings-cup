//
//  CupRain.swift
//  Drinking game
//
//  Created by 是她 on 28/9/2025.
//

import SwiftUI

struct CupRain: View {
    var count: Int = 24
    var emojis: [String] = ["🍺","🥤","🍹","🍸","🍷"]
    var fallDuration: ClosedRange<Double> = 1.2...1.9
    var spin: ClosedRange<Double> = -180...240
    var onFinished: (() -> Void)? = nil

    @State private var drops: [Drop] = []
    @State private var started = false

    struct Drop: Identifiable {
        let id = UUID()
        let emoji: String
        let x: CGFloat   // starting horizontal offset (relative -1...+1)
        let delay: Double
        let dur: Double
        let spin: Double
        var y: CGFloat = -200   // animated down to height + 120
        var opacity: Double = 1
        var angle: Double = 0
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(drops) { d in
                    Text(d.emoji)
                        .font(.system(size: 44))
                        .rotationEffect(.degrees(d.angle))
                        .opacity(d.opacity)
                        .offset(x: d.x * geo.size.width * 0.5,
                                y: d.y)
                }
            }
            .ignoresSafeArea()
            .onAppear {
                // seed the drops once
                guard !started else { return }
                started = true
                drops = (0..<count).map { _ in
                    Drop(
                        emoji: emojis.randomElement()!,
                        x: CGFloat.random(in: -0.95...0.95),
                        delay: Double.random(in: 0.0...0.35),
                        dur: Double.random(in: fallDuration),
                        spin: Double.random(in: spin)
                    )
                }
                // animate each drop
                for i in drops.indices {
                    let delay = drops[i].delay
                    let dur = drops[i].dur
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        withAnimation(.easeIn(duration: dur)) {
                            drops[i].y = geo.size.height + 120
                            drops[i].angle = drops[i].spin
                            drops[i].opacity = 0.0
                        }
                    }
                }
                // call back after the longest animation finishes
                let maxTime = (drops.map { $0.delay + $0.dur }.max() ?? 1.8) + 0.2
                DispatchQueue.main.asyncAfter(deadline: .now() + maxTime) {
                    onFinished?()
                }
            }
        }
    }
}
