//
//  ContentViewTests.swift
//  OnlineHospital
//
//  Created by jiayu chang on 1/20/25.
//

import XCTest
import SwiftUI
@testable import OnlineHospital

final class ContentViewTests: XCTestCase {
    func testSearchFilter() {
        let testStore = PatientStore()
        
        // Initialize test patients safely
        guard let john = Patient(
            medicalRecordNumber: UUID(),
            firstName: "John",
            lastName: "Doe",
            dateOfBirth: Date(),
            heightInCm: 175,
            weightInGrams: 70000,
            bloodType: .abPositive
        ) else {
            XCTFail("Failed to initialize patient: John")
            return
        }
        
        guard let jane = Patient(
            medicalRecordNumber: UUID(),
            firstName: "Jane",
            lastName: "Smith",
            dateOfBirth: Date(),
            heightInCm: 160,
            weightInGrams: 60000,
            bloodType: .oNegative
        ) else {
            XCTFail("Failed to initialize patient: Jane")
            return
        }
        
        // Add patients to the store
        testStore.patients = [john, jane]
        
        // Simulate search input
        let contentView = ContentView()
        contentView.searchText = "Doe"
        
        // Check the filtered patient list
        let filteredPatients = contentView.filteredPatients
        XCTAssertEqual(filteredPatients.count, 1)
        XCTAssertEqual(filteredPatients.first?.lastName, "Doe")
    }
}
