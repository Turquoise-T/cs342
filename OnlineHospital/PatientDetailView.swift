//
//  PatientDetailView.swift
//  OnlineHospital
//
//  Created by jiayu chang on 1/20/25.
//

import SwiftUI

/// Detailed view displaying a patient's information and medications
struct PatientDetailView: View {
    let patient: Patient
    @ObservedObject var store: PatientStore // ObservedObject to manage patient data
    @State private var showingPrescribeMedication = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Full Name: \(patient.firstName) \(patient.lastName)")
                    .font(.title)
                Text("Age: \(Calendar.current.dateComponents([.year], from: patient.dateOfBirth, to: Date()).year ?? 0)")
                    .font(.title2)
                Text("Height: \(patient.heightInCm) cm")
                Text("Weight: \(patient.weightInGrams) g")
                Text("Blood Type: \(patient.bloodType.rawValue)")

                Section(header: Text("Current Medications")) {
                    ForEach(patient.currentMedications(), id: \.datePrescribed) { medication in
                        Text(medication.description)
                    }
                }
            }
            .padding()
            .navigationTitle("Patient Details")
            .toolbar {
                Button("Prescribe Medication") {
                    showingPrescribeMedication.toggle() // Open the prescribe medication form
                }
            }
            .sheet(isPresented: $showingPrescribeMedication) {
                PrescribeMedicationView(patient: patient, store: store)
            }
        }
    }
}
