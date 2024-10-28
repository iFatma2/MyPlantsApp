//
//  MyPlantsDone.swift
//  MyPlantsApp
//
//  Created by Fatimah Alqarni on 19/04/1446 AH.
//

import SwiftUI

struct MyPlantsDone: View {
    
    @Binding var plants: [Plant]
    @State var showingSheet: Bool = false
    //@State var choosenPlant: Plant? // To Store the Plant will be removed
    
    var body: some View {
        
        VStack{
            
            Text("My Plants🌱")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, -90.0)
                .padding(.trailing,200)
            
            Divider()
                .background(Color.white)
                .padding(.top, -60.0)
            
            // Plant Logo
            Image("PlantWink")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .padding(.top, 50.0)
            
            //Plant Journey Text
            Text("All Done🎉!")
                .font(.system(size: 25))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.bottom, 40)
                .frame(width: 273, height: 30.0)
            
            
            Text("All Remibders are Completed!")
                .font(.subheadline)
            
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .frame(width: 315, height: 60)
            
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
                    
                    // Pass the plants to the sheet
                    SheetView(showingSheet: $showingSheet, plants: $plants, choosenPlant: .constant(nil))
                }
            }
            .padding(.trailing, 185.0)
            .frame(width: 450.0, height: 100.0)
        }
    }
    
}

