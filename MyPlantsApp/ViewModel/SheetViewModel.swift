//
//  SheetViewModel.swift
//  MyPlantsApp
//
//  Created by Fatimah Alqarni on 02/05/1446 AH.
//

import SwiftUI
import Combine

class SheetViewModel: ObservableObject {
    @Binding var plants: [Plant]
    
    @Published var plantName: String = ""
    @Published var room: String = "Bedroom"
    @Published var light: String = "Full Sun"
    @Published var wateringDays: String = "Every day"
    @Published var waterAmount: String = ""
    
    @Binding var navigateToTodayReminder: Bool // Binding to navigate
    @Binding var showingSheet: Bool // Binding for showing the sheet
    
    var choosenPlant: Plant?
    
    init(plants: Binding<[Plant]>, choosenPlant: Plant?, showingSheet: Binding<Bool>, navigateToTodayReminder: Binding<Bool>) {
        self._plants = plants
        self.choosenPlant = choosenPlant
        self._showingSheet = showingSheet
        self._navigateToTodayReminder = navigateToTodayReminder // Correct binding initialization
        
        if let plant = choosenPlant {
            self.plantName = plant.name
            self.room = plant.room
            self.light = plant.light
            self.wateringDays = plant.wateringDays
            self.waterAmount = plant.waterAmount
        }
    }

    func savePlant() {
        print("Saving plant: \(plantName)")

        // Save the plant details
        if let plant = choosenPlant {
            if let index = plants.firstIndex(where: { $0.id == plant.id }) {
                plants[index].name = plantName
                plants[index].room = room
                plants[index].light = light
                plants[index].wateringDays = wateringDays
                plants[index].waterAmount = waterAmount
            }
        } else {
            let newPlant = Plant(id: UUID(), name: plantName, room: room, light: light, wateringDays: wateringDays, waterAmount: waterAmount)
            plants.append(newPlant)
        }

        // Set the state to navigate to TodayReminder
        DispatchQueue.main.async {
            self.showingSheet = false  // Close the sheet first
            self.navigateToTodayReminder = true  // Then set navigation to today reminder
        }
    }

    func deletePlant() {
        if let plantToDelete = choosenPlant, let index = plants.firstIndex(where: { $0.id == plantToDelete.id }) {
            print("Deleting plant: \(plantToDelete.name)")
            plants.remove(at: index)
            print("Plant deleted. Remaining plants: \(plants.count)")
        } else {
            print("Plant not found or choosenPlant is nil")
        }
        choosenPlant = nil
        showingSheet = false
    }
}

