//
//  AddPatientView.swift
//  OnlineHospital
//
//  Created by jiayu chang on 1/20/25.
//

import SwiftUI

// Form view for adding a new patient to the system
struct AddPatientView: View {
    @Environment(\.dismiss) var dismiss // Dismiss environment variable to close the form
    @ObservedObject var store: PatientStore // ObservedObject to update the patient store

    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var dateOfBirth: Date = Date()
    @State private var heightInCm: String = ""
    @State private var weightInGrams: String = ""
    @State private var bloodType: BloodType = .unknown

    /// Validates whether the form is complete and all required fields are filled
    var isFormValid: Bool {
        !firstName.isEmpty && !lastName.isEmpty && Int(heightInCm) != nil && Int(weightInGrams) != nil
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Personal Information")) { // Section for personal information
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                }

                Section(header: Text("Physical Attributes")) { // Section for physical attributes
                    TextField("Height (cm)", text: $heightInCm)
                        .keyboardType(.numberPad)
                    TextField("Weight (g)", text: $weightInGrams)
                        .keyboardType(.numberPad)
                }

                Section(header: Text("Blood Type")) { // Section for selecting blood type
                    Picker("Blood Type", selection: $bloodType) {
                        ForEach(BloodType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            .navigationTitle("Add New Patient") // Navigation title for the form
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() } // Cancel button to close the form
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        // Validate and save the patient
                        if let height = Int(heightInCm), let weight = Int(weightInGrams),
                           let newPatient = Patient(
                            medicalRecordNumber: UUID(),
                            firstName: firstName,
                            lastName: lastName,
                            dateOfBirth: dateOfBirth,
                            heightInCm: height,
                            weightInGrams: weight,
                            bloodType: bloodType
                           ) {
                            store.patients.append(newPatient) // Add patient to the store
                            dismiss() // Close the form
                        }
                    }
                    .disabled(!isFormValid) // Disable the save button if the form is invalid
                }
            }
        }
    }
}
