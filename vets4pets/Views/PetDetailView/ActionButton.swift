//
//  ActionButton.swift
//  vets4pets
//
//  Created by Snigdha Tiwari  on 03/09/2025.
//

import SwiftUI

struct ActionButton: View {
    let title: String
    let icon: String
    let colour: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action){
            VStack(spacing: 8){
                Image(systemName: icon)
                    .font(.title2)
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
            }
            .foregroundStyle(colour)
            .frame(maxWidth: .infinity)
            .padding()
            .background(colour.opacity(0.2))
            .cornerRadius(10)
        }
    }
}

#Preview {
    ActionButton(title: "Call Owner", icon: "phone.fill", colour: .green) {
        print("Call tapped")
    }
}
