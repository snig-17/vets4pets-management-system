//
//  Pet.swift
//  vets4pets
//
//  Created by Snigdha Tiwari  on 03/09/2025.
//

import Foundation
import SwiftUI

struct Pet: Identifiable, Codable { //means each pet can be uniquely identified
    let id: UUID
    var name: String
    var species: String
    var breed: String
    var age: String
    var ownerName: String
    var contactNumber: String
    var photoData: Data?
    
    // MARK: - Computed Properties
    var hasOhoto: Bool {
        photoData != nil
    }
    //get UIImage from stored photo data
    var photo: UIImage? {
        guard let photoData = photoData else {return nil}
        return UIImage(data: photoData)
    }
    //get swiftUI image from stored photo data
    var photoImage: Image? {
        guard let uiImage = photo else {return nil}
        return Image(uiImage: uiImage)
    }
    // MARK: - Initialisers
    //default initialiser
    init(name: String, species: String, breed: String, age: String, ownerName: String, contactNumber: String, photoData: Data?) {
        self.id = UUID()
        self.name = name
        self.species = species
        self.breed = breed
        self.age = age
        self.ownerName = ownerName
        self.contactNumber = contactNumber
        self.photoData = photoData
    }
    //initialiser with id
    init(id: UUID, name: String, species: String, breed: String, age: String, ownerName: String, contactNumber: String, photoData: Data?) {
        self.id = id
        self.name = name
        self.species = species
        self.breed = breed
        self.age = age
        self.ownerName = ownerName
        self.contactNumber = contactNumber
        self.photoData = photoData
    }
}

// MARK: - Sample Data
extension Pet {
    static let samplePets: [Pet] = [
        Pet(name: "Buddy", species: "Dog", breed: "Golden Retriever", age: "3 yrs", ownerName: "John Smith", contactNumber: "07787167083", photoData: nil),
        Pet(name: "Ford", species: "Dog", breed: "Husky", age: "7 yrs", ownerName: "John Smith", contactNumber: "07787167083", photoData: nil)
    ]
}
