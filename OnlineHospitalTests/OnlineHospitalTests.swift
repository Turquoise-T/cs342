//
//  OnlineHospitalTests.swift
//  OnlineHospitalTests
//
//  Created by jiayu chang on 1/12/25.
//

import Testing//#expectedNothrow
import XCTest
import Foundation //for usage of UUID() and Date()
@testable import OnlineHospital

struct OnlineHospitalTests {

    @Test func testBloodTypeCompatibility() throws {
        // Test known blood types
        let patient1 = Patient(
            medicalRecordNumber: UUID(),
            firstName: "John",
            lastName: "Doe",
            dateOfBirth: Date(),
            height: 175,
            weight: 70,
            bloodType: .ABPositive
        )
        XCTAssertEqual(patient1.eligibleBloodTypes(), [
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
        //test bonus
        XCTAssertEqual(patient2.eligibleBloodTypes(), [.ONegative])
        
        // Test unknown blood type
        let patient3 = Patient(
            medicalRecordNumber: UUID(),
            firstName: "Unknown",
            lastName: "User",
            dateOfBirth: Date(),
            height: 170,
            weight: 65,
            bloodType: .Unknown
        )
        XCTAssertEqual(patient3.eligibleBloodTypes(), [])
    }

    // Test medication prescription functionality
    @Test func testPrescribeMedication() throws {
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
        
        // Test prescribing multiple medications
        let ibuprofen = Medication(
            datePrescribed: Date(),
            name: "Ibuprofen",
            dose: "200 mg",
            route: "by mouth",
            frequency: 3,
            duration: 10
        )
        XCTAssertNoThrow(try patient.prescribeMedication(ibuprofen))
        XCTAssertEqual(patient.medications.count, 2)
    }
}
