//
//  AddPetView.swift
//  vets4pets
//
//  Created by Snigdha Tiwari  on 03/09/2025.
//

import SwiftUI

struct AddPetView: View {
    // MARK: - Properties
    @ObservedObject var petController: PetController
    let petToEdit: Pet?
    
    // MARK: - States
    // state variables for form inputs
    @State private var name = ""
    @State private var selectedSpecies = "Dog"
    @State private var breed = ""
    @State private var age = ""
    @State private var ownerName = ""
    @State private var contactNumber = ""
    
    let speciesOptions = ["Dog", "Cat"]
    
    // Allows view to dismiss the sheet
        @Environment(\.dismiss) private var dismiss
    
    // MARK: - Computed Properties
    private var isEditMode: Bool {
        petToEdit != nil
    }
    private var navigationTitle: String {
        isEditMode ? "Edit Pet" : "Add New Pet"
    }
    private var saveButtonTitle: String {
        isEditMode ? "Update Pet" : "Save New Pet"
    }
    
    var body: some View {
        NavigationView{
            Form{
                // pet information section
                Section(header: Text("Pet Information")){
                    // name field
                    TextField("Pet name", text: $name) //$ means variable can be read/write
                    // species picker
                    Picker("Species", selection: $selectedSpecies){
                        ForEach(speciesOptions, id: \.self) { species in
                            Text(species).tag(species)
                        }
                    }
                    // breed field
                    TextField("Breed", text: $breed)
                    // age field
                    TextField("Age (e.g 3 yrs)", text: $age)
                }
                // owner information section
                Section(header: Text("Owner Information")){
                    TextField("Owner name", text: $ownerName)
                    TextField("Phone number", text: $contactNumber)
                        .keyboardType(.phonePad)
                }
            }
            .navigationTitle("Add New Pet")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                //cancel button
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel"){
                        dismiss()
                    }
                }
                //save button
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Save"){
                        savePet()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }
    // MARK: - Form Validation
    // check if form is valid
    private var isFormValid: Bool {
        !name.isEmpty &&
        !breed.isEmpty &&
        !age.isEmpty &&
        !ownerName.isEmpty &&
        !contactNumber.isEmpty
    }
    // MARK: - Methods
    private func loadPetData(){
        if let pet = petToEdit {
            name = pet.name
            selectedSpecies = pet.species
            breed = pet.breed
            age = pet.age
            ownerName = pet.ownerName
            contactNumber = pet.contactNumber
        }
    }
    //save the pet
    private func savePet(){
        if isEditMode{
            guard let originalPet = petToEdit else {
                return
            }
            let updatedPet = Pet(
                id: originalPet.id,
                name: name,
                species: selectedSpecies,
                breed: breed,
                age: age,
                ownerName: ownerName,
                contactNumber: contactNumber)
            petController.updatePet(updatedPet)
        } else {
            let newPet = Pet(
                name: name,
                species: selectedSpecies,
                breed: breed,
                age: age,
                ownerName: ownerName,
                contactNumber: contactNumber
            )
            petController.addPet(newPet)
        }
        dismiss()
    }
}
// MARK: - Initializers
extension AddPetView {
    // For adding new pets
    init(petController: PetController) {
        self.petController = petController
        self.petToEdit = nil
    }
    
    // For editing existing pets
    init(petController: PetController, petToEdit: Pet) {
        self.petController = petController
        self.petToEdit = petToEdit
    }
}
#Preview("Add Mode") {
    AddPetView(petController: PetController())
}

#Preview("Edit Mode") {
    AddPetView(petController: PetController(), petToEdit: Pet.samplePets[0])
}
