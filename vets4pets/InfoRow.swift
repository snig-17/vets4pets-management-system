//
//  InfoRow.swift
//  vets4pets
//
//  Created by Snigdha Tiwari  on 03/09/2025.
//

import SwiftUI

struct InfoRow: View {
    let label: String
    let value: String
    var body: some View {
        HStack{
            Text(label)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    VStack(spacing: 8){
        InfoRow(label: "Name", value: "Buddy")
        InfoRow(label: "Breed", value: "Golden Retriever")
        InfoRow(label: "Age", value: "3 years")
    }
    .padding()
}
