//
//  PhotoDisplayView.swift
//  vets4pets
//
//  Created by Snigdha Tiwari  on 05/09/2025.
//

import SwiftUI

struct PhotoDisplayView: View {
    // MARK: - Properties
    let selectedPhoto: Data?
    // MARK: - Computed Properties
    private var displaySize: CGFloat {
        120 //default size
    }
    var body: some View {
        Group {
            if let photoData = selectedPhoto,
               let uiImage = UIImage(data: photoData) {
                //display actual photo
                Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: displaySize, height: displaySize)
                .overlay(
                    Circle()
                        .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                )
            } else {
                ZStack {
                    Circle()
                        .fill(Color.gray.opacity(0.1))
                        .frame(width: displaySize, height: displaySize)
                        .overlay(
                            Circle()
                                .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                        )
                    Image(systemName: "camera.circle.fill")
                        .font(.system(size: 16))
                        .foregroundStyle(.gray.opacity(0.6))
                }
            }
        }
    }
}

// MARK: - Preview
#Preview("With Photo") {
    VStack(spacing: 20) {
        Text("Photo Display Examples")
            .font(.headline)
        
        // Example with photo (you'd need actual data for this)
        PhotoDisplayView(selectedPhoto: nil)
            .frame(width: 120, height: 120)
        
        Text("No Photo Selected")
            .font(.caption)
            .foregroundColor(.secondary)
    }
    .padding()
}

#Preview("Different Sizes") {
    VStack(spacing: 20) {
        Text("Size Variations")
            .font(.headline)
        
        HStack(spacing: 20) {
            VStack {
                PhotoDisplayView(selectedPhoto: nil)
                    .frame(width: 60, height: 60)
                Text("List Size")
                    .font(.caption2)
            }
            
            VStack {
                PhotoDisplayView(selectedPhoto: nil)
                    .frame(width: 120, height: 120)
                Text("Form Size")
                    .font(.caption2)
            }
            
            VStack {
                PhotoDisplayView(selectedPhoto: nil)
                    .frame(width: 150, height: 150)
                Text("Detail Size")
                    .font(.caption2)
            }
        }
    }
    .padding()
}
