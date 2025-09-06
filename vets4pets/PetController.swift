//
//  PetController.swift
//  vets4pets
//
//  Created by Snigdha Tiwari  on 03/09/2025.
//

import Foundation


class PetController: ObservableObject {
    // MARK: - Published Properties
    @Published var pets: [Pet] = []
    // MARK: - Persistence Keys
    private let petsKey = "SavedPets"
    private let userDefaults = UserDefaults.standard
    // MARK: - Initialiser
    init(){
        print("petcontroller initialising")
        loadPets()
        print("Pet controller initialised with \(pets.count) pets loaded from storage")
        
        for(index, pet) in pets.enumerated() {
            print(" \(index + 1). \(pet.name) (\(pet.species))")
        }
    }
    // MARK: - CRUD Operations with autosave
    
    // Add new pet to the collection
    func addPet(_ pet: Pet) {
        pets.append(pet)
        savePets()
        print("Added pet: \(pet.name)")
    }
    // Delete pets at indice
    func deletePets(at offsets: IndexSet){
        let deletedPetNames = offsets.map { pets[$0].name }
        print("🗑️ Deleting pets: \(deletedPetNames.joined(separator: ", "))")
        pets.remove(atOffsets: offsets)
        savePets()
        print("Deleted pet: \(deletedPetNames.joined(separator: ","))")
    }
    // Delete a specific pet
    func deletePet(_ pet: Pet){
        print("deleting pets")
        if let index = pets.firstIndex(where: {$0.id == pet.id }){
            pets.remove(at: index)
            savePets()
            print("Deleted pet: \(pet.name)")
        } else { print("pet not found for deletion")
        }
    }
    // Update an existing pet
    func updatePet(_ updatedPet: Pet){
        print("updating pet")
        if let index = pets.firstIndex(where: { $0.id == updatedPet.id }){
            pets[index] = updatedPet
            savePets()
            print("Updated pet: \(updatedPet.name)")
        } else {
            print("pet not found for update")
        }
    }
    // MARK: - Persistence Methods
    //save all pets to user defaults
    private func savePets(){
        print("attempting to save pets")
        do {
            let encoded = try JSONEncoder().encode(pets)
            userDefaults.set(encoded, forKey: petsKey)
            print("successfully save \(pets.count) pets")
            if let savedData = userDefaults.data(forKey: petsKey) {
                print("🔍 Verification: Found \(savedData.count) bytes in UserDefaults")
            } else {
                print("❌ Verification failed: No data found in UserDefaults after save!")
                        }
        } catch {
            print("error saving pets: \(error.localizedDescription)")
        }
    }
    //load all pets from user default
    private func loadPets(){
        
        guard let data = userDefaults.data(forKey: petsKey) else {
            
            pets = Pet.samplePets
            
            savePets()
            return
        }
        
        
        do {
            let loadedPets = try JSONDecoder().decode([Pet].self, from: data)
            pets = loadedPets
            print("successfully loaded pets from storage")
        } catch {
            print("error loading pets")
            pets = Pet.samplePets
            savePets()
        }
    }
    
    // MARK: - Utility Methods
    func clearAllPets(){
        pets.removeAll()
        savePets()
        print("cleared pets from storage")
    }
    func resetToSampleData(){
        pets = Pet.samplePets
        savePets()
    }
    func petCount(for species: String) -> Int {
        pets.filter { $0.species == species }.count
    }
    var allSpecies: [String] {
        Array(Set(pets.map { $0.species })).sorted()
    }

    // MARK: - Pet Management Methods
    
    // Get total number of pets
    var petCount: Int {
        pets.count
    }
    // Check if pets list is empty
    var isEmpty: Bool {
        pets.isEmpty
    }
    
}
