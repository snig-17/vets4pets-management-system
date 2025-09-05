//
//  PetListView.swift
//  vets4pets
//
//  Created by Snigdha Tiwari  on 03/09/2025.
//

import SwiftUI
import Foundation

struct PetListView: View {
    // MARK: - Controller
    @StateObject private var petController = PetController()
    
    // MARK: - State
    @State private var pets = Pet.samplePets
    @State private var showingAddPet = false //controls whether addPetView is visible
    @State private var petToDelete: Pet?
    @State private var showingDeleteAlert = false
    
    //@State tells SwiftUI to watch and update this variable on view when neccessary
    
    var body: some View {
        NavigationView{
            Group{
                if petController.isEmpty {
                    emptyStateView
                } else {
                    petListView
                }
            }
            .navigationTitle("Vets4Pets")
            .toolbar {
                toolbarContent
            }
            .sheet(isPresented: $showingAddPet) {
                AddPetView(petController: petController)
                }
            .alert("Delete Pet", isPresented: $showingDeleteAlert){
                deleteAlertButtons
            } message: {
                deleteAlertMessage
            }
        }
    }
    // MARK: - Pet List View
    private var petListView: some View {
        List {
            ForEach(petController.pets) { pet in
                NavigationLink(destination: PetDetailView(pet: pet, petController: petController)) {
                    PetRow(pet: pet)
                }
            }
            .onDelete(perform: handleSwipeDelete)
        }
    }
    // MARK: - Empty State View
    private var emptyStateView: some View {
        VStack(spacing: 20){
            Image(systemName: "pawprint")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            Text("No Pets Yet")
                .font(.title2)
                .fontWeight(.semibold)
            Text("Add your first pet to get started!")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            Button("Add Your First Pet") {
                showingAddPet = true
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
    // MARK: - Toolbar Content
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button("Add Pet"){
                showingAddPet = true
            }
        }
    }
    // MARK: - Delete Alert
    private var deleteAlertButtons: some View {
        Group {
            Button("Cancel", role: .cancel){
                petToDelete = nil
            }
            Button("Delete", role: .destructive) {
                if let pet = petToDelete {
                    petController.deletePet(pet)
                    petToDelete = nil
                }
            }
        }
    }
    private var deleteAlertMessage: some View {
        Group {
            if let pet = petToDelete {
                Text("Are you sure you want to remove \(pet.name) from your records? This action cannot be undone.")
            }
        }
    }
    // MARK: - Actions
    private func handleSwipeDelete(at offsets: IndexSet){
        if let firstIndex = offsets.first {
            petToDelete = petController.pets[firstIndex]
            showingDeleteAlert = true
        }
    }
}

#Preview {
    PetListView()
}
