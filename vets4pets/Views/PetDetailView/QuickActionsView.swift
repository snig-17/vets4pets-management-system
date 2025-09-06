//
//  QuickActionsView.swift
//  vets4pets
//
//  Created by Snigdha Tiwari  on 03/09/2025.
//

import SwiftUI

struct QuickActionsView: View {
    let pet:Pet
    var body: some View {
        VStack(spacing: 12){
            Text("Quick Actions")
                .font(.headline)
                .foregroundStyle(.primary)
            HStack(spacing: 16){
                ActionButton(
                    title: "Call Owner",
                    icon: "phone.fill",
                    colour: .green
                ) {
                    // Call action
                    print("Calling \(pet.ownerName)")
                }
                ActionButton(
                    title: "Schedule Visit",
                    icon: "calendar",
                    colour: .blue
                ) {
                    // Schedule action
                    print("Scheduling visit for \(pet.name)")
                }
            }
        }
        .padding()
        .background(Color.orange.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    QuickActionsView(pet: Pet.samplePets[0])
        .padding()
}
