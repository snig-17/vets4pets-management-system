//
//  PetDetailView.swift
//  vets4pets
//
//  Created by Snigdha Tiwari  on 03/09/2025.
//

import SwiftUI

struct PetDetailView: View {
    let pet:Pet
    
    @ObservedObject var petController: PetController
    
    // State for edit functionality
    @State private var showingEditSheet = false
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20){
                PetHeaderView(pet: pet)
                PetInfoSection(pet: pet)
                OwnerInfoSection(pet: pet)
                QuickActionsView(pet: pet)
                Spacer()
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(pet.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                Menu{
                    Button(action: {
                        showingEditSheet = true
                    }) {
                        Label("Edit Pet", systemImage: "pencil")
                    }
                    Divider()
                    Button(role: .destructive, action: {
                        showingDeleteAlert = true
                    }){
                        Label("Delete Pet", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .font(.title2)
                }
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            AddPetView(petController: petController, petToEdit: pet)
        }
        .alert("Delete Pet", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
                        Button("Delete", role: .destructive) {
                            petController.deletePet(pet)
                            // Navigate back after deletion would be nice, but tricky in this setup
                        }
                    } message: {
                        Text("Are you sure you want to delete \(pet.name)? This action cannot be undone.")
                    }
        }

    // MARK: - Actions
    private func callOwner() {
        guard let url = URL(string: "tel:\(pet.contactNumber.replacingOccurrences(of: " ", with: ""))") else { return }
        UIApplication.shared.open(url)
    }
    
    private func scheduleAppointment() {
        print("Scheduling appointment for \(pet.name)")
    }
}


#Preview {
    PetDetailView(pet: Pet.samplePets[0],
    petController: PetController())
}
