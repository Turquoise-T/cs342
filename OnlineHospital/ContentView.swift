//
//  ContentView.swift
//  OnlineHospital
//
//  Created by jiayu chang on 1/12/25.
//

import SwiftUI

/// Main view displaying a list of patients with navigation to detailed views and form for adding new patients
struct ContentView: View {
    @StateObject private var store = PatientStore() // StateObject to manage the patient store's lifecycle
    @State public var searchText: String = "" // State to track the search text
    @State public var showingAddPatient = false // State to control the display of the add patient form

    /// Filters and sorts the patient list based on the search text
    var filteredPatients: [Patient] {
        if searchText.isEmpty {
            return store.patients.sorted { $0.lastName < $1.lastName }
        } else {
            return store.patients.filter { $0.lastName.lowercased().contains(searchText.lowercased()) }
                .sorted { $0.lastName < $1.lastName }
        }
    }

    var body: some View {
        NavigationStack { // NavigationStack to manage navigation between views
            List {
                ForEach(filteredPatients, id: \.medicalRecordNumber) { patient in
                    NavigationLink(destination: PatientDetailView(patient: patient, store: store)) {
                        VStack(alignment: .leading) {
                            Text(patient.fullNameAndAge).font(.headline) // Display patient's name and age
                            Text("Medical Record: \(patient.medicalRecordNumber)")
                                .font(.subheadline)
                                .foregroundColor(.secondary) // Display medical record number
                        }
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always)) // Search bar for filtering
            .navigationTitle("Patients") // Title for the navigation bar
            .toolbar {
                Button(action: { showingAddPatient.toggle() }) { // Button to show add patient form
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddPatient) { // Sheet for the add patient form
                AddPatientView(store: store)
            }
        }
    }
}
