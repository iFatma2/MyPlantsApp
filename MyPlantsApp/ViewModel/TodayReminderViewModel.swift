//
//  Untitled.swift
//  MyPlantsApp
//
//  Created by Fatimah Alqarni on 02/05/1446 AH.
//

import SwiftUI
import Combine

class TodayReminderViewModel: ObservableObject {
    @Published var plants: [Plant]
    @Published var choosenPlant: Plant?
    @Published var showingSheet = false
    @Published var navigateToMyPlantsDone = false
    @Published var navigateToTodayReminder: Bool = false

    init(plants: [Plant]) {
        self.plants = plants
    }

    func checkIfAllChecked() {
        if plants.allSatisfy({ $0.isChecked }) {
            navigateToMyPlantsDone = true
        }
    }

    func togglePlantCheckedStatus(_ plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index].isChecked.toggle()
        }
        checkIfAllChecked()
    }
    
    

    func deletePlant(_ plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants.remove(at: index)
        }
    }
}
