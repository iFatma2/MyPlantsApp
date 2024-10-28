
//  SetReminder.swift
//  MyPlantsApp
//
//  Created by Fatimah Alqarni on 17/04/1446 AH.
//

import SwiftUI

// Struct to Show the sheet Content
struct SheetView: View {
    
    // Vars Section
    @State private var navigateToTodayReminder = false
    @Binding var showingSheet: Bool // Binding the state
    @Binding var plants: [Plant] // Binding to pass Plants List
    @Binding var choosenPlant: Plant? // To store the selected plant for editing/deletion
    
    // Editable plant details
    @State private var plantName: String = ""
    @State private var room: String = "Bedroom"
    @State private var light: String = "Full Sun"
    @State private var wateringDays: String = "Every day"
    @State private var waterAmount: String = "20-50 ml"

    var body: some View {
        NavigationView {
            VStack {
                HStack { // For navigation bar buttons (Cancel, Set reminder and Save)
                    Button("Cancel") {
                        showingSheet = false
                    }
                    .padding(.trailing, 70.0)
                    .foregroundColor(.customGreen)
                    
                    // Title centered
                    Text("Set Reminder")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical)
                    
                    // Save button
                    Button("Save") {
                        if let index = plants.firstIndex(where: { $0.id == choosenPlant?.id }) {
                            // Update the existing plant
                            plants[index].name = plantName
                            plants[index].room = room
                            plants[index].light = light
                            plants[index].wateringDays = wateringDays
                            plants[index].waterAmount = waterAmount
                        } else {
                            // Add a new plant
                            let newPlant = Plant(name: plantName, room: room, light: light, wateringDays: wateringDays, waterAmount: waterAmount)
                            plants.append(newPlant)
                        }
                        navigateToTodayReminder = true
                        //showingSheet = false
                    }
                    .padding(.leading, 70.0)
                    .foregroundColor(.customGreen)
                }
                
                Form {
                    Section {
                        HStack {
                            Text("Plant Name")
                            Divider()
                                .frame(width: 2.0)
                                .background(Color.customGreen)
                            TextField("Enter plant name", text: $plantName)
                        }
                        .cornerRadius(10)
                    }
                    
                    Section {
                        VStack {
                            // Room picker
                            HStack {
                                Image(systemName: "location")
                                Picker("Room", selection: $room) {
                                    Text("Bedroom").tag("Bedroom")
                                    Text("Living Room").tag("Living Room")
                                    Text("Kitchen").tag("Kitchen")
                                }
                                .pickerStyle(MenuPickerStyle())
                            }
                            Divider()
                            
                            // Light picker
                            HStack {
                                Image(systemName: "sun.max")
                                Picker("Light", selection: $light) {
                                    Text("Full Sun").tag("Full Sun")
                                    Text("Partial Sun").tag("Partial Sun")
                                    Text("Low Light").tag("Low Light")
                                }
                                .pickerStyle(MenuPickerStyle())
                            }
                        }
                    }
                    
                    Section {
                        VStack {
                            // Watering days picker
                            HStack {
                                Image(systemName: "drop")
                                Picker("Water Days", selection: $wateringDays) {
                                    Text("Every day").tag("Every day")
                                    Text("Every 2 days").tag("Every 2 days")
                                    Text("Every 3 days").tag("Every 3 days")
                                    Text("Once a week").tag("Once a week")
                                    Text("Every 10 days").tag("Every 10 days")
                                    Text("Every 2 weeks").tag("Every 2 weeks")
                                }
                                .pickerStyle(MenuPickerStyle())
                            }
                            Divider()
                            
                            // Water amount picker
                            HStack {
                                Image(systemName: "drop")
                                Picker("Water", selection: $waterAmount) {
                                    Text("20-50 ml").tag("20-50 ml")
                                    Text("50-100 ml").tag("50-100 ml")
                                    Text("30ml").tag("30ml")
                                    Text("100-200 ml").tag("100-200 ml")
                                    Text("200-300 ml").tag("200-300 ml")
                                }
                                .pickerStyle(MenuPickerStyle())
                            }
                        }
                    }
                    
                    if choosenPlant != nil {
                        Section {
                            HStack {
                                Button(action: {
                                    if let plantToDelete = choosenPlant, let index = plants.firstIndex(where: { $0.id == plantToDelete.id }) {
                                        plants.remove(at: index)
                                    }
                                    choosenPlant = nil
                                    showingSheet = false
                                }) {
                                    Text("Delete Reminder")
                                        .padding(.leading, 100)
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            if let plant = choosenPlant {
                plantName = plant.name
                room = plant.room
                light = plant.light
                wateringDays = plant.wateringDays
                waterAmount = plant.waterAmount
            }
        }
        .fullScreenCover(isPresented: $navigateToTodayReminder) {
            TodayReminder(plants: $plants)
        }
    }
}

#Preview {
    MyPlants()
}
