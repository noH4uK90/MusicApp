//
//  PaywallView.swift
//  MusicApp
//
//  Created by Иван Спирин on 26.11.2025.
//

import SwiftUI

fileprivate struct PaywallPoint: Identifiable {
    let id: UUID = UUID()
    let image: String
    let text: String
}

fileprivate struct PaywallPlan: Identifiable {
    let id: UUID = UUID()
    let title: String
    let price: String
    let description: String
    let option: PaywallOption
}

fileprivate enum PaywallOption {
    case monthly
    case yearly
}

struct PaywallView: View {

    private let paywallPoints: [PaywallPoint] = [
        PaywallPoint(
            image: "play.circle.fill",
            text: "Unlimited ad-free music streaming"
        ),
        PaywallPoint(
            image: "arrow.down.circle.fill",
            text: "Download songs and listen offline"
        ),
        PaywallPoint(
            image: "music.note.list",
            text: "Create and save unlimited playlists"
        ),
        PaywallPoint(
            image: "sparkles",
            text: "Get personalized recommendations daily"
        ),
        PaywallPoint(
            image: "headphones",
            text: "High-quality audio for the best listening experience"
        ),
    ]

    private let paywallPlans: [PaywallPlan] = [
        PaywallPlan(
            title: "Monthly",
            price: "$0.99/month",
            description: "Subscribe for a Month",
            option: .monthly
        ),
        PaywallPlan(
            title: "Yearly",
            price: "$9.99/year",
            description: "Subscribe for a Year",
            option: .yearly
        ),
    ]

    @AppStorage(Sheets.paywall.rawValue) var showPaywall: Bool = true
    @State private var selected: PaywallOption? = nil
    @State private var showProgress: Bool = false

    var body: some View {
        VStack {
            Text("Music App")
                .font(.largeTitle.bold())
            Text("Premium")
                .padding(9)
                .font(.title2.bold())
                .background(.black)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .offset(x: 55)
            
            Image(systemName: "music.note")
                .resizable()
                .foregroundStyle(.red.opacity(0.8).gradient)
                .frame(width: 90, height: 100)
                .padding(.vertical, 20)

            VStack(alignment: .leading, spacing: 25) {
                ForEach(paywallPoints, id: \.id) { point in
                    PaywallPointView(point: point)
                }
            }

            HStack {
                ForEach(paywallPlans, id: \.id) { plan in
                    PriceCardView(
                        title: plan.title,
                        price: plan.price,
                        description: plan.description,
                        option: plan.option,
                        selected: $selected
                    )
                }
            }
            .padding(.vertical)

            Button {
                Task {
                    showProgress = true
                    
                    try await Task.sleep(for: .seconds(3))
                    
                    showPaywall = false
                }
            } label: {
                Text("Subscribe")
                    .font(.system(size: 21).bold())
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background(.black)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .padding(.top)
        }
        .padding()
        .overlay {
            if showProgress {
                ProgressView("Purchase in progress...")
                    .padding(.horizontal, 20)
                    .padding(.vertical, 40)
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemBackground)))
                    .shadow(radius: 10)
            }
        }
    }
}

fileprivate struct PaywallPointView: View {

    var point: PaywallPoint

    var body: some View {
        HStack {
            Image(systemName: point.image)
                .resizable()
                .frame(width: 35, height: 35)
                .symbolVariant(.fill)
                .foregroundStyle(.black)

            Text(point.text)
        }
    }
}

fileprivate struct PriceCardView: View {

    let title: String
    let price: String
    let description: String
    let option: PaywallOption
    @Binding var selected: PaywallOption?

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2.bold())
            Text(price)
                .font(.footnote)
            
            Divider()
            
            Text(description)
                .font(.footnote)
        }
        .onTapGesture { selected = option }
        .overlay(alignment: .topTrailing) {
            if selected == option {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title2)
            } else {
                Image(systemName: "circle")
                    .font(.title2)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.gray.opacity(0.1))
        .background(RoundedRectangle(cornerRadius: 12).stroke(selected == option ? .black : .secondary))
    }
}

#Preview {
    PaywallView()
}
