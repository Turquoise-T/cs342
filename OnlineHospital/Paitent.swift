//
//  Paitent.swift
//  OnlineHospital
//
//  Created by jiayu chang on 1/19/25.
//

import Foundation

struct Patient {
    let medicalRecordNumber: UUID
    let firstName: String
    let lastName: String
    let dateOfBirth: Date
    var heightInCm: Int
    var weightInGrams: Int
    var bloodType: BloodType
    private(set) var medications: [Medication]

    var fullNameAndAge: String {
        let age = Calendar.current.dateComponents([.year], from: dateOfBirth, to: .now).year ?? 0
        return "\(lastName), \(firstName), \(age) years"
    }

    init?(medicalRecordNumber: UUID, firstName: String, lastName: String, dateOfBirth: Date, heightInCm: Int, weightInGrams: Int, bloodType: BloodType = .unknown) {
        guard dateOfBirth <= .now else { return nil }
        self.medicalRecordNumber = medicalRecordNumber
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.heightInCm = heightInCm
        self.weightInGrams = weightInGrams
        self.bloodType = bloodType
        self.medications = []
    }

    func currentMedications(currentDate: Date = .now) -> [Medication] {
        medications.filter { !$0.isCompleted(currentDate: currentDate) }.sorted { $0.datePrescribed < $1.datePrescribed }
    }

    mutating func prescribeMedication(_ medication: Medication) throws {
        guard !currentMedications().contains(where: { $0.name == medication.name }) else {
            throw PatientError.duplicateMedication
        }
        medications.append(medication)
    }

    func eligibleBloodTypes() -> [BloodType] {
        bloodType.compatibleDonors()
    }
}
