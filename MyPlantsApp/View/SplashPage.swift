//
//  SplashPage.swift
//  MyPlantsApp
//
//  Created by Fatimah Alqarni on 24/04/1446 AH.
//

import SwiftUI

struct SplashPage: View {
    @State private var isActive = false
    // Create an instance of TodayReminderViewModel
    @StateObject private var todayReminderViewModel = TodayReminderViewModel(plants: [])
    
    var body: some View {
        if isActive {
            // Pass the view model to MyPlants
            MyPlants()
        } else {
            VStack {
                Image("PlantWink")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Text("My Plants")
                    .font(.largeTitle)
                    .padding()
            }
            .onAppear {
                // Simulate a loading delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashPage()
}



