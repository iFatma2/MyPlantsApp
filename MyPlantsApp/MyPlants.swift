//
//  ContentView.swift
//  MyPlantsApp
//
//  Created by Fatimah Alqarni on 17/04/1446 AH.
//

import SwiftUI

struct MyPlants: View {
    
    var body: some View {
        VStack{
            
            // State bar
            
            
            // Header
            HStack{
                Text("My Plants🌱")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Divider()
                    .background(Color.gray)
                frame(width: 600, height: 1)
                Spacer()
                
            }
            .padding()
            Spacer()
            
            Divider()
                .background(Color.white)
                .frame(width: 6)
            
            VStack{
                // Plant Logo
                Image("PlantLogo")
                    .frame(width: 164, height: 200)
                    //.foregroundColor(.green)
                
                //Plant Journey Text
                Text("Start your plant journey!")
                    .font(.system(size: 25))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 273, height: 30.0)
                
                Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                    .font(.subheadline)
                    
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .frame(width: 315, height: 50)
//                    .padding(.top, 10)
                Spacer()
                
                // Set Plant Reminder Button
                Button(action: {
                    // No Action here} )
                }){
                    Text("Set Plant Reminder")
                        .bold()
                        .padding()
                        .frame(width: 280, height: 50)
                        .background(Color.green)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                    
                    
                }
                Spacer()
                
            }.frame(width: 315, height: 410)
            Spacer()
        }
        .frame(width: 428,height:800)
        .background(Color.black.edgesIgnoringSafeArea(.all)) // Full black background
    }
}

#Preview {
    MyPlants()
}

