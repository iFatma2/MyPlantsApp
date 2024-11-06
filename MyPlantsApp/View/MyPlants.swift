//
////  ContentView.swift
////  MyPlantsApp
////
////  Created by Fatimah Alqarni on 17/04/1446 AH.
//
//import SwiftUI
//
//struct MyPlants: View {
//    @State private var showingSheet = false // For sheet control
//    @State private var plants: [Plant] = []  // Empty list to save items into it
//    @State private var choosenPlant: Plant?
//
//    // Create a viewModel instance
//    @StateObject private var viewModel = SheetViewModel(plants: .constant([]), choosenPlant: nil, showingSheet: .constant(false))
//
//    var body: some View {
//        ZStack {
//            VStack {
//                Text("My Plants🌱")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//                    .padding(.top, 200.0)
//                    .padding(.trailing, 200)
//
//                Divider().background(Color.white)
//
//                Image("PlantLogo")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 300, height: 300)
//                    .padding(.top, 50.0)
//
//                Text("Start your plant journey!")
//                    .font(.system(size: 25))
//                    .fontWeight(.semibold)
//                    .foregroundColor(.white)
//                    .padding(.bottom, 40)
//                    .frame(width: 273, height: 30.0)
//
//                Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
//                    .font(.subheadline)
//                    .fontWeight(.regular)
//                    .multilineTextAlignment(.center)
//                    .foregroundColor(.gray)
//                    .frame(width: 315, height: 60)
//
//                Button("Set Plant Reminder") {
//                    showingSheet.toggle()
//                    viewModel.plants = plants // Set the current plants in the view model
//                    viewModel.choosenPlant = choosenPlant // Set the current chosen plant if any
//                }
//                .bold()
//                .padding()
//                .frame(width: 280, height: 40)
//                .background(Color.customGreen)
//                .foregroundColor(.black)
//                .cornerRadius(10)
//                .sheet(isPresented: $showingSheet) {
//                    // Pass the Binding directly
//                    SheetView(viewModel: SheetViewModel(plants: $plants, choosenPlant: choosenPlant, showingSheet: $showingSheet))
//                }
//                .padding(.bottom, 300)
//                .frame(width: 315, height: 410)
//            }
//        }
//    }
//}
//
//// Custom Green Color
//extension Color {
//    static let customGreen = Color(red: 41/255.0, green: 223 / 255.0, blue: 168/255.0)
//    static let customGray = Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.5)
//    static let customBackground = Color(red: 24.0 / 255.0, green: 24.0 / 255.0, blue: 29.0 / 255.0)
//    static let customTextYellowColor = Color(red: 204.0 / 255.0, green: 199.0 / 255.0, blue: 133.0 / 255.0)
//    static let customTextBlueColor = Color(red: 202.0 / 255.0, green: 243.0 / 255.0, blue: 251.0 / 255.0)
//}
//
//#Preview {
//    MyPlants()
//}
//


import SwiftUI

struct MyPlants: View {
    
    @State private var showingSheet = false
    @State private var plants: [Plant] = []
    @State private var choosenPlant: Plant?
    @State private var navigateToTodayReminder = false


    //@StateObject private var viewModel = SheetViewModel(plants: .constant([]), choosenPlant: nil, showingSheet: .constant(false))

    
    var body: some View {
        ZStack {
            VStack {
                Text("My Plants🌱")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 200.0)
                    .padding(.trailing, 200)

                Divider().background(Color.white)

                Image("PlantLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .padding(.top, 50.0)

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

                Button("Set Plant Reminder") {
                    showingSheet.toggle()
                    //viewModel.plants = plants // Set the current plants in the view model
                    //viewModel.choosenPlant = choosenPlant // Set the current chosen plant if any
                }
                .bold()
                .padding()
                .frame(width: 280, height: 40)
                .background(Color.customGreen)
                .foregroundColor(.black)
                .cornerRadius(10)
                .sheet(isPresented: $showingSheet) {
                    SheetView(viewModel: SheetViewModel(plants: $plants, choosenPlant: choosenPlant, showingSheet: $showingSheet, navigateToTodayReminder: $navigateToTodayReminder)) // Pass the binding
                }
                .padding(.bottom, 300)
                .frame(width: 315, height: 410)
            }
        }
        .fullScreenCover(isPresented: $navigateToTodayReminder) {
            TodayReminder(viewModel: TodayReminderViewModel(plants: plants))
        }
    }
}

// Custom Green Color
extension Color {
    static let customGreen = Color(red: 41/255.0, green: 223 / 255.0, blue: 168/255.0)
    static let customGray = Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.5)
    static let customBackground = Color(red: 24.0 / 255.0, green: 24.0 / 255.0, blue: 29.0 / 255.0)
    static let customTextYellowColor = Color(red: 204.0 / 255.0, green: 199.0 / 255.0, blue: 133.0 / 255.0)
    static let customTextBlueColor = Color(red: 202.0 / 255.0, green: 243.0 / 255.0, blue: 251.0 / 255.0)
}

#Preview {
    MyPlants()
}

