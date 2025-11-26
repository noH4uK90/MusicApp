//
//  MainView.swift
//  MusicApp
//
//  Created by Иван Спирин on 26.11.2025.
//

import Foundation
import SwiftUI

enum Sheets: String {
    case onBoarding = "onBoarding"
    case paywall = "paywall"
}

struct MainView: View {

    struct Playlist: Identifiable {
        let id = UUID()
        let title: String
        let imageName: String
    }

    let playlists = [
        Playlist(title: "Top Hits", imageName: "music.note.list"),
        Playlist(title: "Chill Vibes", imageName: "headphones"),
        Playlist(title: "Workout", imageName: "flame.fill"),
        Playlist(title: "Classical", imageName: "guitars"),
    ]
    
    @AppStorage(Sheets.onBoarding.rawValue) var showOnBoarding = true
    @AppStorage(Sheets.paywall.rawValue) var showPaywall = true

    var body: some View {
        NavigationStack {
            VStack {

                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search music", text: .constant(""))
                        .textFieldStyle(.plain)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Your Playlists")
                            .font(.title2)
                            .bold()
                            .padding(.horizontal)

                        ForEach(playlists) { playlist in
                            HStack {
                                Image(systemName: playlist.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .padding(5)
                                    .background(Color(.systemGray5))
                                    .cornerRadius(10)

                                Text(playlist.title)
                                    .font(.headline)

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    Button("Show onboarding") {
                        showOnBoarding = true
                    }
                    
                    Button("Show paywall") {
                        showPaywall = true
                    }
                }

                HStack {
                    Image(systemName: "music.note")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(5)
                        .background(Color(.systemGray5))
                        .cornerRadius(10)

                    VStack(alignment: .leading) {
                        Text("Now Playing")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("Song Title")
                            .font(.headline)
                    }

                    Spacer()

                    HStack(spacing: 20) {
                        Button {
                            // Previous action
                        } label: {
                            Image(systemName: "backward.fill")
                        }

                        Button {
                            // Play/Pause action
                        } label: {
                            Image(systemName: "play.fill")
                        }

                        Button {
                            // Next action
                        } label: {
                            Image(systemName: "forward.fill")
                        }
                    }
                    .font(.title2)
                }
                .padding()
                .background(Color(.systemGray6))
            }
            .navigationTitle("Music")
            .sheet(isPresented: $showOnBoarding) {
                OnBoardingView()
                    .interactiveDismissDisabled()
            }
            .sheet(isPresented: $showPaywall) {
                PaywallView()
                    .interactiveDismissDisabled()
            }
        }
    }
}

#Preview {
    MainView()
}
