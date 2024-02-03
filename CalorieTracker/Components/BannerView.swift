//
//  BannerView.swift
//  CalorieTracker
//
//  Created by Louis Farmer on 2/2/24.
//

import SwiftUI

struct BannerView: View {
    var image: String
    var message: String
    var body: some View {
        HStack {
            Image(systemName: image)
                .font(.headline)
                .padding()
            Text(message)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .foregroundColor(.white)
        .cornerRadius(10)
        .padding()
    }
}
