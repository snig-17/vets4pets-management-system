//
//  Pet.swift
//  vets4pets
//
//  Created by Snigdha Tiwari  on 03/09/2025.
//

import Foundation
import SwiftUI

struct Pet: Identifiable { //means each pet can be uniquely identified
    let id: UUID
    var name: String
    var species: String
    var breed: String
    var age: String
    var ownerName: String
    var contactNumber: String
    
    // MARK: - Initialisers
    //default initialiser
    init(name: String, species: String, breed: String, age: String, ownerName: String, contactNumber: String) {
        self.id = UUID()
        self.name = name
        self.species = species
        self.breed = breed
        self.age = age
        self.ownerName = ownerName
        self.contactNumber = contactNumber
    }
    //initialiser with id
    init(id: UUID, name: String, species: String, breed: String, age: String, ownerName: String, contactNumber: String) {
        self.id = id
        self.name = name
        self.species = species
        self.breed = breed
        self.age = age
        self.ownerName = ownerName
        self.contactNumber = contactNumber
    }
    
    
    //sample data for testing
    
    static let samplePets = [
        Pet(name: "Buddy", species: "Dog", breed: "Golden Retriever", age: "3 yrs", ownerName: "John Smith", contactNumber: "07787167083"),
        Pet(name: "Ford", species: "Dog", breed: "Husky", age: "7 yrs", ownerName: "John Smith", contactNumber: "07787167083")
    ]
}
