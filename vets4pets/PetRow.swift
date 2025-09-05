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
        HStack(spacing: 30){
            //pet photo
            PhotoDisplayView(selectedPhoto: pet.photoData)
                .frame(width: 40, height: 40)
                .clipped()
                
                
            
            VStack(alignment: .leading){
                Text(pet.name)
                    .font(.headline)
                    .lineLimit(1)
                Text("\(pet.breed) • \(pet.age)")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .lineLimit(1)
                Text(pet.ownerName)
                    .font(.caption)
                    .foregroundStyle(.blue)
                    .lineLimit(1)
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
