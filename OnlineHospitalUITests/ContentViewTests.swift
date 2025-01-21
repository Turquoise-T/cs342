//
//  ContentViewTests.swift
//  OnlineHospital
//
//  Created by jiayu chang on 1/20/25.
//

import XCTest

final class ContentViewTests: XCTestCase {

    func testPrescribeMedication() throws {
        let app = XCUIApplication()
        app.launch()

        // Navigate to the PatientDetailView
        app.buttons["Patients"].tap()
        app.buttons["John Doe"].tap()
        
        // Open the "Prescribe Medication" form
        app.buttons["Prescribe Medication"].tap()

        // Input medication details
        let medicationNameField = app.textFields["Name"]
        XCTAssertTrue(medicationNameField.exists, "Medication name field should exist")
        medicationNameField.tap()
        medicationNameField.typeText("Amoxicillin")

        let doseField = app.textFields["Dose"]
        XCTAssertTrue(doseField.exists, "Dose field should exist")
        doseField.tap()
        doseField.typeText("500")

        let frequencyField = app.textFields["Frequency (per day)"]
        XCTAssertTrue(frequencyField.exists, "Frequency field should exist")
        frequencyField.tap()
        frequencyField.typeText("2")

        let durationField = app.textFields["Duration (days)"]
        XCTAssertTrue(durationField.exists, "Duration field should exist")
        durationField.tap()
        durationField.typeText("7")

        // Select route (Picker)
        let routePicker = app.pickers["Route"]
        XCTAssertTrue(routePicker.exists, "Route picker should exist")
        routePicker.tap()
        app.pickerWheels.element.adjust(toPickerWheelValue: "Oral") // Adjust to "Oral" route

        // Save the medication
        app.buttons["Save"].tap()

        // Assert that the medication was saved and the form was dismissed
        XCTAssertFalse(app.textFields["Name"].exists, "The form should be dismissed after saving")

        // Verify the medication appears in the Current Medications section
        let medicationText = app.staticTexts["Amoxicillin"]
        XCTAssertTrue(medicationText.exists, "New medication should appear in the Current Medications section")
    }
}
