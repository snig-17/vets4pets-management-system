//
//  PetRow.swift
//  vets4pets
//
//  Created by Snigdha Tiwari  on 03/09/2025.
//

import SwiftUI

struct PetRow: View {
    let pet: Pet
    var body: some View {
        HStack{
            //pet icon
            Text(pet.species).font(.largeTitle)
            VStack(alignment: .leading){
                Text(pet.name)
                    .font(.headline)
                Text("\(pet.breed) • \(pet.age)")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                Text(pet.ownerName)
                    .font(.caption)
                    .foregroundStyle(.blue)
            }
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    VStack(spacing: 10){
        PetRow(pet: Pet.samplePets[0])
        PetRow(pet: Pet.samplePets[1])
    }
    .padding()
}
