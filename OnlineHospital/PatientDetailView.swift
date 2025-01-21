//
//  PatientDetailView.swift
//  OnlineHospital
//
//  Created by jiayu chang on 1/20/25.
//

import SwiftUI

// A detailed view that displays a patient's personal information, medical details, and current medications.
// This view also provides functionality to prescribe new medications to the patient.
struct PatientDetailView: View {
    let patient: Patient
    @ObservedObject var store: PatientStore //for all patient-related data
    @State private var showingPrescribeMedication = false //allows shared access and updates to patient data across multiple views

    var body: some View {
        // use scrollview to deal with the situation that it exceeds the screen's height
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Full Name: \(patient.firstName) \(patient.lastName)")
                    .font(.title)
                Text("Age: \(Calendar.current.dateComponents([.year], from: patient.dateOfBirth, to: Date()).year ?? 0)")
                    .font(.title2)
                Text("Height: \(patient.heightInCm) cm")
                Text("Weight: \(patient.weightInGrams) g")
                Text("Blood Type: \(patient.bloodType.rawValue)")
                
                //displaying a list of the patient's current medications under a labeled section
                Section(header: Text("Current Medications")) {
                    ForEach(patient.currentMedications(), id: \.datePrescribed) { medication in
                        Text(medication.description)
                    }
                }
            }
            .padding()
            .navigationTitle("Patient Details")
            // adding a toolbar botton to prescribe new medications
            .toolbar {
                Button("Prescribe Medication") {
                    showingPrescribeMedication.toggle() // Open the prescribe medication form
                }
            }
            // add a sheet, when showingPresribedMedication is true, the sheet will present the prescibeMedicationView
            .sheet(isPresented: $showingPrescribeMedication) {
                PrescribeMedicationView(patient: patient, store: store)
            }
        }
    }
}
