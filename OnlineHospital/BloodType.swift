//
//  BloodType.swift
//  OnlineHospital
//
//  Created by jiayu chang on 1/19/25.
//

enum BloodType: String, CaseIterable {
    // should add CaseIterable here because:
    // When a Swift enumeration conforms to the CaseIterable protocol, the compiler automatically generates an allCases property, which provides a collection of all possible values of the enumeration. this is good for our coding
    case aPositive = "A+"
    case aNegative = "A-"
    case bPositive = "B+"
    case bNegative = "B-"
    case oPositive = "O+"
    case oNegative = "O-"
    case abPositive = "AB+"
    case abNegative = "AB-"
    case unknown = "Unknown"
    
    func compatibleDonors() -> [BloodType] {
        switch self {
        case .oPositive: return [.oPositive, .oNegative]
        case .oNegative: return [.oNegative]
        case .aPositive: return [.aPositive, .aNegative, .oPositive, .oNegative]
        case .aNegative: return [.aNegative, .oNegative]
        case .bPositive: return [.bPositive, .bNegative, .oPositive, .oNegative]
        case .bNegative: return [.bNegative, .oNegative]
        case .abPositive: return BloodType.allCases.filter { $0 != .unknown }
        case .abNegative: return [.aNegative, .bNegative, .oNegative, .abNegative]
        case .unknown: return []
        }
    }
}
