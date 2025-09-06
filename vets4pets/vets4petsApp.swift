//
//  vets4petsApp.swift
//  vets4pets
//
//  Created by Snigdha Tiwari  on 01/09/2025.
//

import SwiftUI


@main
struct vets4petsApp: App {
    // MARK: - Shared Data Controller
    @StateObject private var petController = PetController()

    var body: some Scene {
        WindowGroup {
            PetListView()
                .environmentObject(petController)
                .onAppear{
                    print("Vets4Pets launched with \(petController.pets.count) pets")
                }
        }
        
    }
}
