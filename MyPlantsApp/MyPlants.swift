
//  ContentView.swift
//  MyPlantsApp
//
//  Created by Fatimah Alqarni on 17/04/1446 AH.

import SwiftUI

struct Plant: Identifiable {
    var id: UUID = UUID()          // Automatically assigns a new UUID as default
    var name: String
    var room: String
    var light: String
    var wateringDays: String
    var waterAmount: String
    var isChecked: Bool
    
    // Custom initializer with default id
    init(id: UUID = UUID(), name: String, room: String, light: String, wateringDays: String, waterAmount: String, isChecked: Bool = false) {
        self.id = id
        self.name = name
        self.room = room
        self.light = light
        self.wateringDays = wateringDays
        self.waterAmount = waterAmount
        self.isChecked = isChecked
    }
}


//struct Plant: Identifiable {
//    var id = UUID()
//    var name: String
//    var room: String
//    var light: String
//    var wateringDays: String
//    var waterAmount: String
//    var isChecked: Bool = false
//}

struct MyPlants: View {
    
    // Vars section
    @State private var showingSheet = false //for sheet control
    @State private var plants: [Plant] = []  // Empty list to save items into it
    @State private var choosenPlant: Plant?

    
    
    var body: some View {
        
        ZStack{
            
            // State bar
            VStack{
                
                Text("My Plants🌱")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 200.0)
                    .padding(.trailing,200)
                
                Divider()
                    .background(Color.white)
                
                // Plant Logo
                Image("PlantLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .padding(.top, 50.0)
                
                //Plant Journey Text
                Text("Start your plant journey!")
                    .font(.system(size: 25))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.bottom, 40)
                    .frame(width: 273, height: 30.0)
                
                
                Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                    .font(.subheadline)
                
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .frame(width: 315, height: 60)
                
                // Set Plant Reminder Button
                Button("Set Plant Reminder"){
                    showingSheet.toggle()
                }
                .bold()
                .padding()
                .frame(width: 280, height: 40)
                .background(Color.customGreen)
                .foregroundColor(.black)
                .cornerRadius(10)
                .sheet(isPresented: $showingSheet){
                    SheetView(showingSheet: $showingSheet, plants: $plants, choosenPlant: $choosenPlant)
                }
                .padding(.bottom, 300)
                .frame(width: 315, height: 410)
            }
        }
    }
}

// Custom Green Color
extension Color{
    static let customGreen = Color(red: 41/255.0, green: 223 / 255.0, blue: 168/255.0)
//    static let customGray = Color(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0).opacity(0.5)
    static let customGray = Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.5)
    static let customBackground = Color(red: 24.0 / 255.0, green: 24.0 / 255.0, blue: 29.0 / 255.0)
    static let customTextYellowColor = Color(red: 204.0 / 255.0, green: 199.0 / 255.0, blue: 133.0 / 255.0)
    static let customTextBlueColor = Color(red: 202.0 / 255.0, green: 243.0 / 255.0, blue: 251.0 / 255.0)
}

#Preview{
    MyPlants()
}
