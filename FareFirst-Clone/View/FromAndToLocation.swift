//
//  FromAndToLocation.swift
//  FareFirst-Clone
//
//  Created by Sachin H K on 19/09/24.
//

import SwiftUI

struct FromAndToLocation: View {

    @EnvironmentObject var flightViewModel : FlightViewModel
    @EnvironmentObject var resultScreenManager : ResultScreenManager
    @Environment(\.dismiss) private var dismiss
    @State var From : String = ""
    @State var To : String = ""
    

    var body: some View {
        VStack(spacing:0) {
            HStack {
                HStack {
                    Image(systemName: Constants.Images.magnifying_glass).padding(.leading,5)
                    TextField("Enter City or airport", text: $flightViewModel.searchQuerry)
                        .padding(15).autocorrectionDisabled(true)
                    
                        .overlay(Image(systemName:Constants.Images.xmark_circle_fill)
                            .padding()
                            .offset(x:10)
                            .opacity(flightViewModel.searchQuerry.isEmpty ? 0.0 : 1.0)
                            .onTapGesture {
                                flightViewModel.searchQuerry = ""
                            },alignment: .trailing)
                }.font(.subheadline)
                    .background(RoundedRectangle(cornerRadius: 10.0)
                        .fill(Color(.systemGray3))
                        .foregroundStyle(Color.gray))
                
                    .padding()
                if !flightViewModel.searchQuerry.isEmpty {
                    Button {
                        flightViewModel.searchQuerry = ""
                        flightViewModel.locationData = []
                       
                    }label: {
                        Text("Cancel")
                    }.padding(.trailing,5)
                }
                
                
            }
            .background(Color(.systemGray6))
            .scrollDismissesKeyboard(.immediately)
            
            List (flightViewModel.locationData) { data in
                HStack {
                    VStack(alignment: .leading){
                        
                        Text(data.cityName ?? "place")
                        HStack {
                            Text("\(data.mainAirportName ?? "Any Airport"),")
                            Text(data.countryName ?? "Country")
                        }.foregroundStyle(Color(.systemGray))
                    }
                    Spacer()
                    Text(data.iataCode ?? "ABC")
                        .fontWeight(.semibold)
                    
                }.background()
                    .onTapGesture {
                    if From == Constants.TitleBar.origin {
                        flightViewModel.fromLocation = data
                    }
                    if To == Constants.TitleBar.destination {
                        flightViewModel.toLocation = data
                    }
                    
                    dismiss()
                    flightViewModel.searchQuerry = ""
                    flightViewModel.locationData = []
                   
                }.padding(.vertical,3)
                    .font(.caption)
                    .foregroundStyle(Color.black)
                 
            }.scrollDismissesKeyboard(.immediately)
            
        }
        .listStyle(.plain)
        .onChange(of: flightViewModel.searchQuerry) { newValue in
            print("newValue",newValue)
                if !flightViewModel.searchQuerry.isEmpty {  
                    resultScreenManager.fetchLocationDetail(searchString: newValue)
            }
        }
        
    }
    
    
    
}




#Preview {
    ContentView()
}
