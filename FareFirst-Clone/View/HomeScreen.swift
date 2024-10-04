//
//  HomeScreen.swift
//  FareFirst-Clone
//
//  Created by Sachin H K on 14/09/24.
//

import SwiftUI

struct HomeScreen: View {
    //    @StateObject var flightViewModel : FlightViewModel = FlightViewModel()
    //    @StateObject var resultScreenManager : ResultScreenManager = ResultScreenManager()
    
    //#
    @EnvironmentObject var flightViewModel : FlightViewModel
    @EnvironmentObject var resultScreenManager : ResultScreenManager
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    @State  var  trip: Int = 0
    @State var showPop = false
    @State var showResultPage = false
   
    
    var body: some View {
        ZStack {
            
            VStack {
                ZStack {
                    Color(UIColor(red: 0, green: 0, blue: 255, alpha: 0.9))
                    Image(Constants.Images.flight_background)
                        .resizable()
                        .opacity(0.5)
                        .blur(radius: 2)
                    VStack {
                        Trip()
                        Spacer()
                        Location()
                        Spacer()
                    }
                    
                }.ignoresSafeArea()
                
                DateAndTraveller( showPop: $showPop)
                
                VStack {
                  
                    
                    Button(action: {
                       
                        buttonAction()
                        print("navigation")
                        
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Search Flights")
                                .padding()
                                .textCase(.uppercase)
                                .font(.headline)
                                .foregroundStyle(Color.white)
                            Spacer()
                        }.background(
                            Color(.blue).clipShape(RoundedRectangle(cornerRadius: 5)).padding(.horizontal))
                    })
                    .alert("Error", isPresented: $flightViewModel.homescreenSearchAlert, actions: {
                       
                    }, message: {
                        flightViewModel.alertText()
                        
                    })
                    
                    
                }
                Divider()
            }
            
            if showPop {
                
                Color.black.opacity(showPop ? 0.3 : 0)
                VStack(spacing : 0) {
                    Text("Passengers and class").font(.headline).fontWeight(.heavy).foregroundStyle(Color.gray).padding(.top,20)
                    PopPage(passengers: Constants.PopUpPage.adult, year: "Over 16 y.o")
                    PopPage(passengers: Constants.PopUpPage.children, year: " 2-15 y.o")
                    PopPage(passengers: Constants.PopUpPage.infant, year: "0-2 y.o")
                    
                    Text("passengers cannot be more than 9").foregroundStyle(.red).font(.subheadline).padding()
                        .opacity(flightViewModel.toastText ? 1 : 0)
                 
                    
                    HStack {
                        ForEach( flightViewModel.passengerClass.indices, id: \.self) {
                            index in
                            Text(flightViewModel.passengerClass[index])
                                .frame(width: 80)
                        }
                    }
                    
                 
                    
                    Slider(value : $flightViewModel.sliderValue, in: 0...3, step: 1).tint(Color(.systemGray5 )).padding()
                    
                    Divider()
                    Button {
                        showPop.toggle()
                    } label: {
                        Text("Done").frame(maxWidth: .infinity,maxHeight: 50).bold()
                    }
                }
                .background(.white,in: RoundedRectangle(cornerRadius: 10))
                .padding(.all)
            }
        }.environmentObject(flightViewModel)
            .environmentObject(resultScreenManager)
        
     
    }
   
    func buttonAction() {
        resultScreenManager.flightViewModel = flightViewModel
        if flightViewModel.fromLocation.iataCode == flightViewModel.toLocation.iataCode {
            flightViewModel.homescreenSearchAlert.toggle()
        }
        else {
            if flightViewModel.trip == 0 {
                
                   resultScreenManager.searchResult()
 
                flightViewModel.path.append(NavigationDestions.OneWaySearchButton)
            }
            else {
                if flightViewModel.deparatureDate <= flightViewModel.returnDate {
   
                      resultScreenManager.searchResult()
                    flightViewModel.path.append(NavigationDestions.TwoWaySearchButton)
                }
                else {
                    flightViewModel.homescreenSearchAlert.toggle()
                }
                
            }
        }
    }

}

#Preview {
    ContentView()
}
