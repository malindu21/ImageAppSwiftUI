//
//  MainView.swift
//  Digmi
//
//  Created by Malinduk on 2024-11-26.
//

import Foundation
import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            AddPhotoView()
                .tabItem {
                    Label("Add Photos", systemImage: "photo.fill.on.rectangle.fill")
                }

            ViewPhotosView()
                .tabItem {
                    Label("View Photos", systemImage: "photo.on.rectangle.angled")
                }
        }
    }
}
