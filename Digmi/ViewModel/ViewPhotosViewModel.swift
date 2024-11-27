//
//  ViewPhotosViewModel.swift
//  Digmi
//
//  Created by Malinduk on 2024-11-27.
//

import Foundation
import FirebaseDatabaseInternal

class ViewPhotosViewModel: ObservableObject {
    @Published var imageURLs: [String] = []

    private let databaseRef = Database.database().reference()

    func fetchImageURLs() {
        // Listening to changes in the "images" node of the Firebase database
        
        databaseRef.child("images").observe(.value) { snapshot in
            var urls: [String] = []
            for child in snapshot.children {
                if let snap = child as? DataSnapshot,
                   let url = snap.value as? String {
                    urls.append(url)
                }
            }
            
            // Update the published imageURLs array on the main thread (for UI updates)
            DispatchQueue.main.async {
                self.imageURLs = urls
            }
        }
    }
}
