//
//  ViewPhotosView.swift
//  Digmi
//
//  Created by Malinduk on 2024-11-26.
//

import FirebaseDatabaseInternal
import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct ViewPhotosView: View {
    @StateObject private var viewModel = ViewPhotosViewModel()
    @State private var selectedImageURL: ImageItem? = nil
    @State private var urlText: String = ""

    var body: some View {
        NavigationView {
            List(viewModel.imageURLs, id: \.self) { url in
                HStack {
                    // Image thumbnail
                    WebImage(url: URL(string: url))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 8))

                    // TextField to display the image URL
                    TextField("Image URL", text: .constant(url))
                        .font(.subheadline)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .frame(maxWidth: .infinity)

                    // Button to view the image in full screen
                    Button(action: {
                        selectedImageURL = ImageItem(id: UUID().uuidString, url: url)
                    }) {
                        Image(systemName: "eye.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.blue)
                            .padding(.leading)
                    }
                }
                .padding(5)
            }
            .navigationTitle("View Photos")
            .onAppear {
                viewModel.fetchImageURLs()
            }
            .sheet(item: $selectedImageURL) { item in
                FullImageView(imageURL: item.url)
            }
        }
    }
}
