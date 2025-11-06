//
//  Drinking_gameApp.swift
//  Drinking game
//
//  Created by 是她 on 23/9/2025.
//

import SwiftUI

@main
struct Drinking_gameApp: App {
    @StateObject private var game = GameState()
    var body: some Scene {
        WindowGroup {
            MainMenuView()
                .environmentObject(game)
        }
    }
}
