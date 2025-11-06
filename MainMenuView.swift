import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject private var game: GameState

    var body: some View {
        NavigationStack {
            ZStack {
                // optional: reuse your background image
                Image("bg")
                    .resizable().scaledToFill()
                    .ignoresSafeArea()
                    .overlay(Color.black.opacity(0.25))

                ScrollView {
                    VStack(spacing: 16) {
                        Text("King’s Cup")
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                            .shadow(radius: 6)
//                            .padding(.top, 8)

                        MenuTileCompact(title: "King's Cup", subtitle: "Flip cards & follow rules", systemImage: "play.circle.fill", tint: .blue) {
                            // reset (optional) before starting
                            ContentView()
                        }
                        MenuTileCompact(title: "Play", subtitle: "Flip cards & follow rules", systemImage: "play.circle.fill", tint: .blue) {
                            // reset (optional) before starting
                            TouchRandom()
                        }
//                        MenuTileCompact(title: "Play", subtitle: "Flip cards & follow rules", systemImage: "play.circle.fill", tint: .blue) {
//                            // reset (optional) before starting
//                            ContentView()
//                        }

//                        MenuCard(title: "How to Play", subtitle: "All the rules at a glance", systemImage: "list.bullet.rectangle.portrait.fill", tint: .purple) {
//                            RulesListView()
//                        }
//
//                        MenuCard(title: "Custom Rules", subtitle: "Tweak ranks and text", systemImage: "slider.horizontal.3", tint: .orange) {
//                            CustomRulesView()
//                        }
//
//                        MenuCard(title: "Settings", subtitle: "Sounds, themes & safety", systemImage: "gearshape.fill", tint: .gray) {
//                            SettingsView()
//                        }
//
//                        MenuCard(title: "About", subtitle: "Credits & version", systemImage: "info.circle.fill", tint: .teal) {
//                            AboutView()
//                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                }
            }
        }
    }
}

private struct MenuTileCompact<Destination: View>: View {
    let title: String
    let subtitle: String
    let systemImage: String
    let tint: Color
    var onTap: (() -> Void)? = nil
    @ViewBuilder var destination: Destination

    var body: some View {
        NavigationLink {
            destination.navigationBarTitleDisplayMode(.inline)
        } label: {
            HStack(spacing: 14) {
                Image(systemName: systemImage)
                    .font(.system(size: 28))
                    .foregroundStyle(.white)
                    .frame(width: 56, height: 56)
                    .background(tint.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 35))
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title).font(.headline)
                    Text(subtitle).font(.subheadline).foregroundStyle(.secondary)
                }
//                    .frame(maxWidth: 360)
//                    .padding(.horizontal)
                Spacer()
                Image(systemName: "chevron.right").foregroundStyle(.secondary)
            }
            .padding(16)
            .frame(maxWidth: 360)
            .background(.ultraThickMaterial, in: RoundedRectangle (cornerRadius: 25, style: .continuous))
            .shadow(color: .black.opacity(0.12), radius: 6, y: 2)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(radius: 6, y: 2)
            .padding(.horizontal, 16)
        }
        .simultaneousGesture(TapGesture().onEnded { onTap?() })
    }
}
