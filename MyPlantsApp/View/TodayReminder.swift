//
//  TodayReminder.swift
//  MyPlantsApp
//  Created by Fatimah Alqarni on 18/04/1446 AH.
//

import SwiftUI

struct TodayReminder: View {
    @ObservedObject var viewModel: TodayReminderViewModel

    var body: some View {
        ZStack {
            VStack {
                Text("My Plants🌱")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.trailing, 200)

                Divider().background(Color.white)

                Text("Today")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.trailing, 290)

                List {
                    let sortedPlants = viewModel.plants.sorted { !$0.isChecked && $1.isChecked }

                    ForEach(sortedPlants) { plant in
                        VStack(alignment: .center) {
                            PlantRow(plant: plant, viewModel: viewModel)
                        }
                    }
                }
                .listStyle(PlainListStyle())

                NewReminderButton(viewModel: viewModel)
            }
            .fullScreenCover(isPresented: $viewModel.navigateToMyPlantsDone) {
                MyPlantsDone(plants: $viewModel.plants)
            }
            .fullScreenCover(isPresented: $viewModel.navigateToTodayReminder) {
                // Pass the plants directly if needed
                MyPlantsDone(plants: $viewModel.plants)
            }
        }
    }
}

struct PlantRow: View {
    let plant: Plant
    @ObservedObject var viewModel: TodayReminderViewModel

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Image(systemName: "location")
                    .resizable()
                    .frame(width: 18.0, height: 18.0)
                Text(plant.room)
            }
            .foregroundColor(.customGray)
            .padding(.trailing, 180.0)

            HStack {
                PlantCircle(isChecked: plant.isChecked) {
                    viewModel.togglePlantCheckedStatus(plant)
                }

                Text(plant.name)
                    .font(.title)
                    .padding(.leading, 10)
                    .frame(width: 100)
                    .onTapGesture {
                        viewModel.choosenPlant = plant
                        viewModel.showingSheet = true
                    }
                    .sheet(isPresented: $viewModel.showingSheet) {
                        SheetView(viewModel: SheetViewModel(plants: $viewModel.plants, choosenPlant: viewModel.choosenPlant, showingSheet: $viewModel.showingSheet, navigateToTodayReminder: $viewModel.navigateToTodayReminder))
                    }
            }
            .padding(.trailing, 220)

            PlantDetails(plant: plant)

            Divider().background(Color.white)
        }
        .swipeActions {
            Button {
                viewModel.deletePlant(plant)
            } label: {
                Image(systemName: "trash")
            }
            .tint(.red)
        }
    }
}

struct PlantCircle: View {
    var isChecked: Bool
    var onToggle: () -> Void

    var body: some View {
        ZStack {
            Circle()
                .fill(isChecked ? Color.customGreen : Color("customGray"))
                .frame(width: 30.0, height: 30.0)
                .overlay(Circle().stroke(Color.customGray, lineWidth: 1))
                .onTapGesture {
                    onToggle()
                }

            Image(systemName: isChecked ? "checkmark" : "")
                .foregroundColor(.black)
                .font(.title)
                .opacity(isChecked ? 1 : 0)
        }
    }
}

struct PlantDetails: View {
    var plant: Plant

    var body: some View {
        HStack(spacing: 20.0) {
            HStack {
                Image(systemName: "sun.max")
                Text(plant.light)
            }
            .frame(width: 90, height: 30)
            .foregroundColor(.customTextYellowColor)
            .background(Color.customBackground)
            .cornerRadius(9)

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
    }
}

struct NewReminderButton: View {
    @ObservedObject var viewModel: TodayReminderViewModel

    var body: some View {
        HStack {
            Button(action: {
                viewModel.showingSheet.toggle()
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
//            .sheet(isPresented: $viewModel.showingSheet) {
//                // Correct instantiation of SheetView
//                SheetView(viewModel: SheetViewModel(plants: viewModel.plants, choosenPlant: viewModel.choosenPlant, showingSheet: $viewModel.showingSheet))
//            }
            .sheet(isPresented: $viewModel.showingSheet) {
                SheetView(viewModel: SheetViewModel(plants: $viewModel.plants, choosenPlant: viewModel.choosenPlant, showingSheet: $viewModel.showingSheet, navigateToTodayReminder: $viewModel.navigateToTodayReminder))
            }

        }
        .padding(.trailing, 185.0)
        .frame(width: 450.0, height: 100.0)
    }
}

#Preview {
    TodayReminder(viewModel: TodayReminderViewModel(plants: [Plant(name: "Pothos", room: "Bedroom", light: "Full Sun", wateringDays: "Every day", waterAmount: "20-50 ml")]))
}

