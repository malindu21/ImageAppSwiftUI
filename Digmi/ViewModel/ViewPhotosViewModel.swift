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
        databaseRef.child("images").observe(.value) { snapshot in
            var urls: [String] = []
            for child in snapshot.children {
                if let snap = child as? DataSnapshot,
                   let url = snap.value as? String {
                    urls.append(url)
                }
            }
            DispatchQueue.main.async {
                self.imageURLs = urls
            }
        }
    }
}
