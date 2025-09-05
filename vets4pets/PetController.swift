//
//  PetController.swift
//  vets4pets
//
//  Created by Snigdha Tiwari  on 03/09/2025.
//

import Foundation
import SwiftUI

class PetController: ObservableObject {
    // MARK: - Published Properties
    @Published var pets: [Pet] = Pet.samplePets
    // MARK: - Pet Management Methods
    // Add new pet to the collection
    func addPet(_ pet: Pet) {
        pets.append(pet)
        print("Added pet: \(pet.name)")
    }
    // Delete pets at indice
    func deletePets(at offsets: IndexSet){
        let deletedPetNames = offsets.map { pets[$0].name }
        pets.remove(atOffsets: offsets)
        print("Deleted pet: \(deletedPetNames.joined(separator: ","))")
    }
    // Delete a specific pet
    func deletePet(_ pet: Pet){
        if let index = pets.firstIndex(where: {$0.id == pet.id }){
            pets.remove(at: index)
            print("Deleted pet: \(pet.name)")
        }
    }
    // Update an existing pet
    func updatePet(_ updatedPet: Pet){
        if let index = pets.firstIndex(where: { $0.id == updatedPet.id }){
            pets[index] = updatedPet
            print("Updated pet: \(updatedPet.name)")
        }
    }
    // Get total number of pets
    var petCount: Int {
        pets.count
    }
    // Check if pets list is empty
    var isEmpty: Bool {
        pets.isEmpty
    }
    
}
