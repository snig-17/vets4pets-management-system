//
//  OwnerInfoSection.swift
//  vets4pets
//
//  Created by Snigdha Tiwari  on 03/09/2025.
//

import SwiftUI

struct OwnerInfoSection: View {
    let pet:Pet
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            Text("Owner Information")
                .font(.headline)
                .foregroundStyle(.primary)
            InfoRow(label: "Owner", value: pet.ownerName)
            InfoRow(label: "Phone", value: pet.contactNumber)
        }
        .padding()
        .background(Color.green.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    OwnerInfoSection(pet: Pet.samplePets[0])
        .padding()
}
