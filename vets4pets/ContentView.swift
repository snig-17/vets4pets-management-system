//
//  ContentView.swift
//  vets4pets
//
//  Created by Snigdha Tiwari on 01/09/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        PetListView()
    }
}

// MARK: - App Entry Point
@main
struct Vets4PetsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

#Preview {
    ContentView()
}
