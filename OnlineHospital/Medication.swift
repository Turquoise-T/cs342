import Foundation
enum Route: String, CaseIterable {
    case oral
    case intravenous
    case intramuscular
    case subcutaneous
    case topical
    case unknown
}

struct Medication {
    let datePrescribed: Date
    let name: String
    let dose: Dosage
    let route: Route
    let frequencyPerDay: Int
    let durationDays: Int

    var description: String {
        "\(name) \(dose.value)\(dose.unit) via \(route.rawValue), \(frequencyPerDay) times daily for \(durationDays) days"
    }

    func isCompleted(currentDate: Date = .now) -> Bool {
        guard let endDate = Calendar.current.date(byAdding: .day, value: durationDays, to: datePrescribed) else { return false }
        return currentDate > endDate
    }
}
