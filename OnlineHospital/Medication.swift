//
//  Medication.swift
//  OnlineHospital
//
//  Created by jiayu chang on 1/12/25.
//

import Foundation


enum BloodType: String{
    case APositive = "A+"
    case ANegative = "A-"
    case BPositive = "B+"
    case BNegative = "B-"
    case OPositive = "O+"
    case ONegative = "O-"
    case ABPositive = "AB+"
    case ABNegative = "AB-"
    case Unknown = "Unknown" // blood type might not be known at the time of creating a patient
    
    func compatibleDonors() -> [BloodType] {
        switch self {
        case .OPositive:
            return [.OPositive, .ONegative]
        case .ONegative:
            return [.ONegative]
        case .APositive:
            return [.APositive, .ANegative, .OPositive, .ONegative]
        case .ANegative:
            return [.ANegative, .ONegative]
        case .BPositive:
            return [.BPositive, .BNegative, .OPositive, .ONegative]
        case .BNegative:
            return [.BNegative, .ONegative]
        case .ABPositive:
            return [.APositive, .ANegative, .BPositive, .BNegative, .OPositive, .ONegative, .ABPositive, .ABNegative]
        case .ABNegative:
            return [.ANegative, .BNegative, .ONegative, .ABNegative]
        case .Unknown:
            return []
        }
    }
}

enum PatientError: Error {
    case duplicateMedication
}

struct Medication{
    let datePrescribed: Date   // the date begin to take medicine
    let name: String  //name of the medicine
    let dose: String  //eg. 25mg
    let route: String  //how to take the medicine
    let frequency: Int  //times everyday
    let duration: Int  //how long the patient take the medicine
    
    func description()->String{
        return "\(name) \(dose) \(route), should take \(frequency) times daily for \(duration) days"
    }

    // see if the medication is completed
    func isCompleted(currentDate: Date = Date()) -> Bool {
        let endDate = Calendar.current.date(byAdding: .day, value: duration, to:datePrescribed)!
        return currentDate > endDate
    }
    
}

struct Patient{
    let medicalRecordNumber: UUID
    let firstName: String
    let lastName: String
    let dateOfBirth: Date
    var height: Double
    var weight: Double
    var bloodType: BloodType
    var medications: [Medication]
    
    init(medicalRecordNumber: UUID, firstName: String, lastName: String, dateOfBirth: Date, height: Double, weight: Double, bloodType: BloodType = .Unknown) {
        self.medicalRecordNumber = medicalRecordNumber
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.height = height
        self.weight = weight
        self.bloodType = bloodType
        self.medications = []
    }
    //get the name and age of the patients
    func getDetailedInfo() -> String{
        let age = Calendar.current.dateComponents([.year], from: dateOfBirth, to: Date()).year!
        return "\(lastName),\(firstName),\(age) years"
    }
    
    func currentMedications(currentDate: Date = Date()) -> [Medication] {
        return medications.filter { !$0.isCompleted(currentDate: currentDate) }
            .sorted { $0.datePrescribed < $1.datePrescribed }
        }
    
    mutating func prescribeMedication(_ medication: Medication) throws {
        if currentMedications().contains(where: { $0.name == medication.name }) {
            throw PatientError.duplicateMedication
        }
        medications.append(medication)
    }
    
    //extension: decide which bloodType can the patients get
    func eligibleBloodTypes() -> [BloodType] {
        return bloodType.compatibleDonors()
    }
}



