//
//  FullImageView.swift
//  Digmi
//
//  Created by Malinduk on 2024-11-27.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct FullImageView: View {
    var imageURL: String
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            // Close button
            HStack {
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                        .padding()
                }
            }

            WebImage(url: URL(string: imageURL))
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.8))
                .cornerRadius(12)
                .padding()

        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .navigationBarTitleDisplayMode(.inline)
    }
}
