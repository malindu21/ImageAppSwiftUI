//
//  PhotoViewModel.swift
//  Digmi
//
//  Created by Malinduk on 2024-11-26.
//
import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseDatabase

class PhotoViewModel: ObservableObject {
    @Published var selectedImage: UIImage?
    @Published var isUploading: Bool = false

    private let storageRef = Storage.storage().reference()
    private let databaseRef = Database.database().reference()

    // Function to clear the selected image (for resetting the image picker or cancelling)
    func clearImage() {
        selectedImage = nil
    }

    // Function to upload the selected image to Firebase Storage
    func uploadImage(completion: @escaping (Bool) -> Void) {
        guard let image = selectedImage,
              let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(false)
            return
        }

        isUploading = true
        let imageId = UUID().uuidString
        let imageRef = storageRef.child("images/\(imageId).jpg")

        // Upload image to Firebase Storage
        imageRef.putData(imageData, metadata: nil) { [weak self] _, error in
            if let error = error {
                print("Failed to upload image: \(error.localizedDescription)")
                self?.isUploading = false
                completion(false)
                return
            }

            // Get the image URL and save it in Firebase Realtime Database
            imageRef.downloadURL { url, error in
                self?.isUploading = false
                if let error = error {
                    print("Failed to get download URL: \(error.localizedDescription)")
                    completion(false)
                    return
                }

                guard let url = url else {
                    completion(false)
                    return
                }

                self?.saveImageURL(url.absoluteString) { success in
                    completion(success)
                }
            }
        }
    }

    // Function to save the image URL to Firebase Realtime Database
    private func saveImageURL(_ url: String, completion: @escaping (Bool) -> Void) {
        databaseRef.child("images").childByAutoId().setValue(url) { error, _ in
            if let error = error {
                print("Failed to save image URL: \(error.localizedDescription)")
                completion(false)
                return
            }
            completion(true)
        }
    }
}
