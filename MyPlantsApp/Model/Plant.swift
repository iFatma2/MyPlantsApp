//
//  Plant.swift
//  MyPlantsApp
//
//  Created by Fatimah Alqarni on 02/05/1446 AH.
//


import SwiftUI

struct Plant: Identifiable {
    var id = UUID()  // Add this if you don't already have an `id` field
    var name: String
    var room: String
    var light: String
    var wateringDays: String
    var waterAmount: String
    var isChecked: Bool = false
}

//struct Plant: Identifiable {
//    var id: UUID = UUID()          // Automatically assigns a new UUID as default
//    var name: String
//    var room: String
//    var light: String
//    var wateringDays: String
//    var waterAmount: String
//    var isChecked: Bool
//    
//    // Custom initializer with default id
//    init(id: UUID = UUID(), name: String, room: String, light: String, wateringDays: String, waterAmount: String, isChecked: Bool = false) {
//        self.id = id
//        self.name = name
//        self.room = room
//        self.light = light
//        self.wateringDays = wateringDays
//        self.waterAmount = waterAmount
//        self.isChecked = isChecked
//    }
//}
