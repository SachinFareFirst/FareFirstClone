//
//  Location.swift
//  FareFirst-Clone
//
//  Created by Sachin H K on 19/09/24.
//

import SwiftUI

struct Location: View {
    @EnvironmentObject var flightViewModel : FlightViewModel
  

    
    
    var body: some View {
        HStack {
            Spacer()
            NavigationLink(value: NavigationDestions.From) {
                VStack {
                    Text(" From ") .frame(maxWidth: .infinity)
                    Text(flightViewModel.fromLocation.iataCode ?? "nil").font(.largeTitle).bold()
                    Text(flightViewModel.fromLocation.cityName ?? "citynname").font(.headline)
                   
                }
                .foregroundStyle(Color.white)
            }
            
            Spacer()
            Image(systemName: "arrow.left.arrow.right")
                .resizable()
                .frame(width: 20, height: 20)
                .padding()
                .scaledToFit()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 0.8).frame(width: 40))
                .foregroundStyle(Color.white)
                .onTapGesture {
                    flightViewModel.changeSelectedPlaces()
                }
            
            Spacer()
            
            NavigationLink(value:NavigationDestions.To) {
                VStack {
                    Text(" To ") .frame(maxWidth: .infinity)
                    Text(flightViewModel.toLocation.iataCode ?? "iataCode").font(.largeTitle).bold()
                    Text(flightViewModel.toLocation.cityName ?? "city Name").font(.headline)
                }.foregroundStyle(Color.white)
            }
            Spacer()


        }
    }
  
}


#Preview {
    ContentView()
}


