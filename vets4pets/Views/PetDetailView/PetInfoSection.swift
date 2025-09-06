//
//  PetInfoSection.swift
//  vets4pets
//
//  Created by Snigdha Tiwari  on 03/09/2025.
//

import SwiftUI

struct PetInfoSection: View {
    let pet: Pet
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            Text("Pet Information")
                .font(.headline)
                .foregroundStyle(.primary)
            InfoRow(label: "Name", value: pet.name)
            InfoRow(label: "Species", value: pet.species)
            InfoRow(label: "Breed", value: pet.breed)
            InfoRow(label: "Age", value: pet.age)
        
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    PetInfoSection(pet: Pet.samplePets[0])
        .padding()
}
