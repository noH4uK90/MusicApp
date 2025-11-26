//
//  OnBoardingView.swift
//  MusicApp
//
//  Created by Иван Спирин on 26.11.2025.
//

import SwiftUI

fileprivate struct OnBoardingPoint: Identifiable {
    let id: UUID = UUID()
    let image: String
    let text: String
}

struct OnBoardingView: View {
    
    private let onboardingPoints: [OnBoardingPoint] = [
        OnBoardingPoint(
            image: "music.note.list",
            text: "Discover millions of songs and create your own playlists."
        ),
        OnBoardingPoint(
            image: "headphones",
            text: "Listen anytime, anywhere with offline mode."
        ),
        OnBoardingPoint(
            image: "flame.fill",
            text: "Get personalized recommendations just for you."
        ),
        OnBoardingPoint(
            image: "guitars",
            text: "Explore new artists and trending hits every day."
        ),
        OnBoardingPoint(
            image: "star.fill",
            text: "Save your favorite tracks and share with friends."
        )
    ]
    
    @AppStorage(Sheets.onBoarding.rawValue) var showOnBoarding: Bool = true
    
    var body: some View {
        VStack {
            Image(systemName: "music.note")
                .resizable()
                .foregroundStyle(.red.opacity(0.8).gradient)
                .frame(width: 90, height: 100)
                .padding(.vertical, 20)
                
            HStack {
                Text("Welcome to the Music App")
                    .font(.title3.bold())
                
                Spacer()
            }
            .padding(.vertical)
            
            VStack(alignment: .leading, spacing: 25) {
                ForEach(onboardingPoints, id: \.id) { point in
                    OnBoardingPointView(point: point)
                }
            }
            
            Button {
                showOnBoarding = false
            } label: {
                Text("Continue")
                    .font(.system(size: 21).bold())
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background(.red.gradient)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .padding(.top, 60)
        }
        .padding()
    }
}

fileprivate struct OnBoardingPointView: View {
    
    var point: OnBoardingPoint
    
    var body: some View {
        HStack(spacing: 13) {
            Image(systemName: point.image)
                .resizable()
                .frame(width: 35, height: 35)
                .symbolVariant(.fill)
                .foregroundStyle(.red.opacity(0.8).gradient)
            
            Text(point.text)
        }
    }
}

#Preview {
    OnBoardingView()
}
