//
//  PrescribeMedicationView.swift
//  OnlineHospital
//
//  Created by jiayu chang on 1/20/25.
//

import SwiftUI

struct PrescribeMedicationView: View {
    let patient: Patient
    @ObservedObject var store: PatientStore
    @Environment(\.dismiss) var dismiss

    @State private var name: String = ""
    @State private var dose: String = ""
    @State private var route: Route = .oral
    @State private var frequency: String = ""
    @State private var duration: String = ""
    @State private var errorMessage: String?

    // Validates whether the medication form is complete
    var isFormValid: Bool {
        !name.isEmpty && !dose.isEmpty && Int(frequency) != nil && Int(duration) != nil
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(
                    header: Text("Medication Details"), //when and how to use closure
                    content: {
                        TextField("Name", text: $name)
                        TextField("Dose", text: $dose)
                        Picker("Route", selection: $route) {
                            ForEach(Route.allCases, id: \.self) { route in
                                Text(route.rawValue).tag(route)
                            }
                        }
                        TextField("Frequency (per day)", text: $frequency)
                            .keyboardType(.numberPad)
                        TextField("Duration (days)", text: $duration)
                            .keyboardType(.numberPad)
                    }
                )


                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("Prescribe Medication")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() } // Cancel button to close the form
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        // Validate and save medication
                        guard let freq = Int(frequency), let dur = Int(duration) else { return }
                        let newMedication = Medication(
                            datePrescribed: Date(),
                            name: name,
                            dose: Dosage(value: Int(dose) ?? 0, unit: "mg"),
                            route: route,
                            frequencyPerDay: freq,
                            durationDays: dur
                        )
                        if patient.medications.contains(where: { $0.name == name }) {
                            errorMessage = "Medication already prescribed."
                        } else {
                            // Replace the patient in the store
                            store.patients = store.patients.map { p in
                                if p.medicalRecordNumber == patient.medicalRecordNumber {
                                    var updatedPatient = p // Create a mutable copy of the patient
                                    updatedPatient.medications.append(newMedication) // Modify the copy
                                    return updatedPatient // Return the updated patient
                                }
                                return p
                            }
                            dismiss() // Close the sheet
                        }
                    }
                    .disabled(!isFormValid) // Disable the save button if the form is invalid
                }
            }
        }
    }
}
