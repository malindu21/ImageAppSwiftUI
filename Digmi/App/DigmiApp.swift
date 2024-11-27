//
//  DigmiApp.swift
//  Digmi
//
//  Created by Malinduk on 2024-11-26.
//

import SwiftUI
import Firebase

@main
struct DigmiApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
    }
}
