
//  SetReminder.swift
//  MyPlantsApp
//
//  Created by Fatimah Alqarni on 17/04/1446 AH.
//

import SwiftUI

// Struct to Show the sheet Content
struct SheetView: View {
    @ObservedObject var viewModel: SheetViewModel

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    // Cancel button
                    Button("Cancel") {
                        viewModel.showingSheet = false
                        //viewModel.showingSheet = false

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
                        viewModel.savePlant()
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
                            TextField("Enter plant name", text: $viewModel.plantName)
                        }
                        .cornerRadius(10)
                    }
                    
                    Section {
                        VStack {
                            // Room picker
                            HStack {
                                Image(systemName: "location")
                                Picker("Room", selection: $viewModel.room) {
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
                                Picker("Light", selection: $viewModel.light) {
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
                                Picker("Water Days", selection: $viewModel.wateringDays) {
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
                                Picker("Water", selection: $viewModel.waterAmount) {
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
                    
                    if viewModel.choosenPlant != nil {
                        Section {
                            HStack {
                                Button(action: {
                                    viewModel.deletePlant()
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
        .fullScreenCover(isPresented: $viewModel.navigateToTodayReminder) {
            TodayReminder(viewModel: TodayReminderViewModel(plants: viewModel.plants))
        }
    }
}
