
//  TodayReminder.swift
//  MyPlantsApp
//  Created by Fatimah Alqarni on 18/04/1446 AH.

import SwiftUI

struct TodayReminder: View {
    
    @Binding var plants: [Plant]
    @State var showingSheet: Bool = false
    @State var choosenPlant: Plant? // To store the plant to be deleted
    @State var navigateToMyPlantsDone: Bool = false // For navigation
    
    // To check if all plants are checked
    private func checkIfAllChecked() {
        if plants.allSatisfy({ $0.isChecked }) {
            navigateToMyPlantsDone = true
        }
    }
    
    // To delete a plant
    private func deletePlant(_ plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants.remove(at: index)
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                
                // Section 1: Header & Divider
                Text("My Plants🌱")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.trailing, 200)
                
                Divider().background(Color.white)
                
                // Section 2: Plants for that Day (Today)
                Text("Today")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.trailing, 290)
                
                // Section 3: For each Check Button Plants 🌱
                List {
                    // Sort plants so checked ones go to the bottom
                    let sortedPlants = plants.sorted { !$0.isChecked && $1.isChecked }
                    
                    ForEach(sortedPlants) { plant in
                        VStack(alignment: .center) {
                            
                            // 🔅 For Plants Room 🔅
                            HStack {
                                Image(systemName: "location")
                                    .resizable()
                                    .frame(width: 18.0, height: 18.0)
                                Text(plant.room)
                            }
                                .foregroundColor(.customGray)
                                .padding(.trailing, 180.0)
                            
                            // 🌸 For Check Button & Plants Name 🌸
                            HStack {
                                ZStack {
                                    // Circle as a background
                                    Circle()
                                        .fill(plant.isChecked ? Color.customGreen : Color("customGray"))
                                        .frame(width: 30.0, height: 30.0)
                                        .overlay(Circle().stroke(Color.customGray, lineWidth: 1))
                                        .onTapGesture {
                                            if let index = plants.firstIndex(where: { $0.id == plant.id }) {
                                                plants[index].isChecked.toggle() // Use plants here
                                            }
                                            checkIfAllChecked()
                                        }

                                    // Checkmark icon inside the circle
                                    Image(systemName: plant.isChecked ? "checkmark" : "")
                                        .foregroundColor(.black)
                                        .font(.title)
                                        .opacity(plant.isChecked ? 1 : 0) // Show icon only if checked
                                }
                                
                                Text(plant.name)
                                    .font(.title)
                                    .padding(.leading, 10)
                                    .frame(width: 100)
                                    .onTapGesture {
                                        choosenPlant = plant
                                        showingSheet = true
                                    }
                                    .sheet(isPresented: $showingSheet) {
                                        SheetView(showingSheet: $showingSheet, plants: $plants, choosenPlant: $choosenPlant)
                                    }
                            }
                            .padding(.trailing, 220)

                            // 💡 For Light & Watering Amount 💦
                            HStack(spacing: 20.0) {
                                // 💡 For Light 💡
                                HStack {
                                    Image(systemName: "sun.max")
                                    Text(plant.light)
                                }
                                .frame(width: 90, height: 30)
                                .foregroundColor(.customTextYellowColor)
                                .background(Color.customBackground)
                                .cornerRadius(9)
                                
                                // 💦 Watering Amount 💦
                                HStack {
                                    Image(systemName: "drop")
                                    Text(plant.waterAmount)
                                }
                                .frame(width: 120, height: 30)
                                .foregroundColor(.customTextBlueColor)
                                .background(Color.customBackground)
                                .cornerRadius(9)
                            }
                            .padding(.trailing, 60)
                            .padding(.bottom, 5)

                            Divider().background(Color.white)
                        }
                        
                        // Swipe To Delete
                        .swipeActions {
                            Button {
                                deletePlant(plant)
                            } label: {
                                Image(systemName: "trash")
                                    .resizable()
                                    .frame(width: 100.0, height: 100.0)
                                    .padding(100.0)
                            }
                        }
                        .tint(.red)
                    }
                }
                .listStyle(PlainListStyle())
                
                HStack {
                    Button(action: {
                        showingSheet.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 30.0, height: 30.0)
                        Text("New Reminder")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.leading, 10)
                    }
                    .foregroundColor(.customGreen)
                    .sheet(isPresented: $showingSheet) {
                        SheetView(showingSheet: $showingSheet, plants: $plants, choosenPlant: $choosenPlant)
                    }
                }
                .padding(.trailing, 185.0)
                .frame(width: 450.0, height: 100.0)
            }
            .fullScreenCover(isPresented: $navigateToMyPlantsDone) {
                MyPlantsDone(plants: $plants) // Navigate to MyPlantsDone page
            }
        }
    }
}

#Preview {
    TodayReminder(plants: .constant([Plant(name: "Pothos", room: "Bedroom", light: "Full Sun", wateringDays: "Every day", waterAmount: "20-50 ml")]))
}

