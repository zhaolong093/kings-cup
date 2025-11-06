//
//  ContentView.swift
//  Drinking game
//
//  Created by 是她 on 23/9/2025.
//

import SwiftUI
import UIKit
import AVFoundation
var player: AVAudioPlayer?

struct ContentView: View {
    @EnvironmentObject private var game: GameState
    @State private var flipAngle: Double = 0
    @State private var showingFront: Bool = false
    @State private var showEndAlert: Bool = false
    @State private var showCupRain = false
    private let flipDuration: Double = 0.5
    
    var body: some View {
//        ZStack{
//            Image("bg")
//                .resizable()
//                .scaledToFill()
//                .ignoresSafeArea()
            
            VStack (spacing: 16){
                
                header
                ZStack {
                    // BACK
                    CardBackView()
                        .opacity(showingFront ? 0 : 1)
                        .rotation3DEffect(.degrees(flipAngle),
                                          axis: (x: 0, y: 1, z: 0),
                                          perspective: 0.8)
                    
                    // FRONT (add scaleEffect to un-mirror the 180° rotation)
                    CardFaceView(title: frontTitle, subtitle: frontSubtitle)
                        .opacity(showingFront ? 1 : 0)
                    //                               .rotation3DEffect(.degrees(flipAngle + 180),
                    //                                                 axis: (x: 0, y: 1, z: 0),
                    //                                                 perspective: 0.8) (This is not working -> Still Fixing!!)
                    //                               .scaleEffect(x: -1, y: 1) // <-- fixes backwards text/numbers
                }
                .frame(height: 260)
                
                HStack {
                    Button(game.deck.isEmpty ? "Deck Empty" : "Draw Card") {
                        flipToShowNewCard()
                    }
                    .disabled(game.deck.isEmpty)
                    .padding(16)
                    .background(game.deck.isEmpty ? .gray.opacity(0.2) : .blue)
                    .foregroundStyle(game.deck.isEmpty ? Color.secondary : .white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    
                    
                    Button("Reset Deck") {
                        game.resetDeck()
                        showingFront = false
                        flipAngle = 0
                    }
                    .padding()
                }
            }
            .overlay {
                if showCupRain {
                    CupRain(count: 28) {
                        showCupRain = false
                    }
                }
            }
            .padding()
            .alert(isPresented: $showEndAlert) {
                Alert(
                    title: Text("👑 Game Over!"),
                    message: Text(" 🍺 Fourth King Drawn — King's Cup!"),
                    dismissButton: .destructive(Text("Reset Deck")) {
                        game.resetDeck()
                        showingFront = false
                        flipAngle = 0
                        showEndAlert = false
                    }
                )
            }
        }
    
    
    private var header: some View {
        VStack( alignment:.leading, spacing: 6){
            HStack {
                Label("\(game.pileCount)", systemImage: "rectangle.stack")
                Spacer()
                Text(game.deck.isEmpty ? "0 Left" : "\(52 - game.pileCount) left")
                    .foregroundStyle(.secondary)
            }
            .font(.headline)
            
            HStack (spacing: 8){
                Label("\(game.kingsDrawn)/4 Kings", systemImage: "crown")
                if game.kingsDrawn >= 4{
                    Text("Game Over - King's Cup!!")
                        .font(.headline).bold()
                        .foregroundStyle(.red)
                }
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
    }
    
    // MARK: - Derived card text
       private var frontTitle: String {
           if let c = game.lastCard { return "\(c.rank.label) \(c.suit.emoji)" }
           return "?"
       }
       private var frontSubtitle: String? {
           if let c = game.lastCard { return RuleBook.classic[c.rank]?.description } // note: RuleBook (your file’s casing)
           return "Tap Draw"
       }

       // MARK: - Flip animation driver
       private func flipToShowNewCard() {
           UIImpactFeedbackGenerator(style: .light).impactOccurred()

           // Step 1: start on the back
           showingFront = false

           // Step 2: rotate to 90° (half flip)
           withAnimation(.easeIn(duration: flipDuration / 2)) {
               flipAngle = 90
           }

           // Step 3: at mid-flip, draw the new card and reveal the front
           DispatchQueue.main.asyncAfter(deadline: .now() + flipDuration / 2) {
               game.draw()
               showingFront = true
               
               if game.kingsDrawn >= 4 {
                   showCupRain = true            // 🎉 start the effect
                   showEndAlert = true           // your existing alert
               }
               
               if game.lastCard?.rank == .King {
                   impact(.heavy)
                   playsound("King")
               }
               
               

               // Step 4: finish to 180°
               withAnimation(.easeOut(duration: flipDuration / 2)) {
                   flipAngle = 180
               }

               // Step 5: normalize angle so next flip starts from 0 (no visual jump)
               DispatchQueue.main.asyncAfter(deadline: .now() + flipDuration / 2) {
                   flipAngle = 0
               }
           }
       }
        // MARK: Haptics & sound
        @State private var audioplayer: AVAudioPlayer?
        
        private func playsound(_ named:String){
            if let url = Bundle.main.url(forResource: named, withExtension: "wav"){
                audioplayer = try? AVAudioPlayer(contentsOf: url)
                audioplayer?.prepareToPlay()
                audioplayer?.play()
            }
        }
        private func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle){
            UIImpactFeedbackGenerator(style: style).impactOccurred()
            
        }
   }
#Preview {
    ContentView()
}
