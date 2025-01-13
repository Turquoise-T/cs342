//
//  OnlineHospitalTests.swift
//  OnlineHospitalTests
//
//  Created by jiayu chang on 1/12/25.
//

import Testing
import XCTest
import Foundation //for usage of UUID() and Date()
@testable import OnlineHospital

struct OnlineHospitalTests {

    // Test blood type compatibility
    @Test func testBloodTypeCompatibility() async throws {
        let patient1 = Patient(
            medicalRecordNumber: UUID(),
            firstName: "John",
            lastName: "Doe",
            dateOfBirth: Date(),
            height: 175,
            weight: 70,
            bloodType: .ABPositive
        )
        
        // Check compatible blood types for AB+ patient
        #expect(patient1.eligibleBloodTypes() == [
            .APositive, .ANegative, .BPositive, .BNegative, .OPositive, .ONegative, .ABPositive, .ABNegative
        ])
        
        let patient2 = Patient(
            medicalRecordNumber: UUID(),
            firstName: "Jane",
            lastName: "Smith",
            dateOfBirth: Date(),
            height: 160,
            weight: 60,
            bloodType: .ONegative
        )
        
        // Check compatible blood types for O- patient
        #expect(patient2.eligibleBloodTypes() == [.ONegative])
    }

    // Test medication prescription functionality
    @Test func testPrescribeMedication() async throws {
        var patient = Patient(
            medicalRecordNumber: UUID(),
            firstName: "Alice",
            lastName: "Johnson",
            dateOfBirth: Date(),
            height: 165,
            weight: 65,
            bloodType: .BPositive
        )
        
        let aspirin = Medication(
            datePrescribed: Date(),
            name: "Aspirin",
            dose: "81 mg",
            route: "by mouth",
            frequency: 1,
            duration: 90
        )
        
        // Check if the first prescription succeeds
        XCTAssertNoThrow(try patient.prescribeMedication(aspirin))
                
        // Check if prescribing the same medication throws an error
        XCTAssertThrowsError(try patient.prescribeMedication(aspirin)) { error in
            XCTAssertEqual(error as? PatientError, PatientError.duplicateMedication)
        }
    }
}
