//
//  PetHeaderView.swift
//  vets4pets
//
//  Created by Snigdha Tiwari  on 03/09/2025.
//

import SwiftUI

struct PetHeaderView: View {
    let pet: Pet
    var body: some View {
        HStack{
            Text(pet.species)
                .font(.system(size: 80))
            VStack(alignment: .leading, spacing: 8){
                Text(pet.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text(pet.breed)
                    .font(.title2)
                    .foregroundStyle(.gray)
                Text(pet.age)
                    .font(.title3)
                    .foregroundStyle(.blue)
            }
            Spacer()
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    PetHeaderView(pet: Pet.samplePets[0])
}
