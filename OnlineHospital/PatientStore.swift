//
//  PatientStore.swift
//  OnlineHospital
//
//  Created by jiayu chang on 1/20/25.
//
import Foundation


class PatientStore: ObservableObject {
    @Published var patients: [Patient] = [] // @Published allows views to update when the list changes
}

