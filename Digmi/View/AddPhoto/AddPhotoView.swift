//
//  AddPhotoView.swift
//  Digmi
//
//  Created by Malinduk on 2024-11-26.
//

import SwiftUI
import UIKit
import PhotosUI

struct AddPhotoView: View {
    @StateObject private var viewModel = PhotoViewModel()
    @State private var isPresentingPicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary

    var body: some View {
        VStack {
            // Displaying selected image or a placeholder
            if let image = viewModel.selectedImage {
                ZStack {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .shadow(radius: 10)
                }
                .padding(.bottom, 20)
            } else {
                Text("No image selected")
                    .foregroundColor(.gray)
                    .padding(.bottom, 20)
            }

            // Action buttons for gallery, camera, and clearing image
            HStack(spacing: 20) {
                Button(action: {
                    sourceType = .photoLibrary
                    isPresentingPicker = true
                }) {
                    Image(systemName: "photo.on.rectangle.angled")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
                .buttonStyle(PlainButtonStyle())

                Button(action: {
                    sourceType = .camera
                    isPresentingPicker = true
                }) {
                    Image(systemName: "camera")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
                .buttonStyle(PlainButtonStyle())

                Button(action: {
                    viewModel.clearImage()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(viewModel.selectedImage == nil)
            }
            .padding(.bottom, 20) // Add some space below the buttons

            // Upload image button
            if viewModel.selectedImage != nil {
                Button(action: {
                    viewModel.uploadImage { success in
                        if success {
                            print("Image uploaded successfully!")
                        } else {
                            print("Failed to upload image.")
                        }
                    }
                }) {
                    HStack {
                        if viewModel.isUploading {
                            ProgressView()
                                .padding()
                        } else {
                            Text("Upload Image")
                                .bold()
                                .padding()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(radius: 10)
                    .padding(.top, 20) // Add top padding to create space from the buttons
                }
                .disabled(viewModel.isUploading)
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(20)
        .shadow(radius: 15)
        .padding()
        .sheet(isPresented: $isPresentingPicker) {
            ImagePickerView(selectedImage: $viewModel.selectedImage, sourceType: sourceType)
        }
    }
}
