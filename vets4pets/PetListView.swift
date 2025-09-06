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
    @EnvironmentObject var petController: PetController
    
    // MARK: - State
    @State private var showingAddPet = false //controls whether addPetView is visible
    @State private var petToDelete: Pet?
    @State private var showingDeleteAlert = false
    
    //@State tells SwiftUI to watch and update this variable on view when neccessary
    
    var body: some View {
        NavigationView{
            Group {
                if petController.pets.isEmpty {
                    emptyStateView
                } else {
                    petListView
                }
            }
            .navigationTitle("My Pets")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddPet = true
                    }){
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddPet) {
                AddPetView(petController: petController).environmentObject(petController)
            }
            .alert("Delete Pet", isPresented: $showingDeleteAlert, presenting: petToDelete) { pet in
                Button("Cancel", role: .cancel) {
                    petToDelete = nil
                }
                Button("Delete", role: .destructive) {
                    petController.deletePet(pet)
                    petToDelete = nil
                }
            } message: { pet in
                Text("Are you sure you want to remove \(pet.name) from your records? This action cannot be undone.")
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
    // MARK: - Actions
    private func handleSwipeDelete(at offsets: IndexSet){
        if let firstIndex = offsets.first {
            petToDelete = petController.pets[firstIndex]
            showingDeleteAlert = true
        }
    }
}

#Preview {
    PetListView().environmentObject(PetController())
}
