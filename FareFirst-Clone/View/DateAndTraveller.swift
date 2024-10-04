//
//  DateAndTraveller.swift
//  FareFirst-Clone
//
//  Created by Sachin H K on 19/09/24.
//

import SwiftUI


struct DateAndTraveller: View {
    @EnvironmentObject var flightViewModel : FlightViewModel
    @Binding var showPop : Bool
    @State private var calenderId = UUID()
    
    
    var oneYear : Date {
        return Calendar.current.date(byAdding: .year, value: 1, to: .now) ?? Date.now
    }
    var body: some View {
   
        VStack {
            VStack {
                HStack {
                    Deparature()
                        .overlay (
                            DatePicker("", selection: $flightViewModel.deparatureDate, in: Date.now...oneYear, displayedComponents: [.date])
                                .id(calenderId)
                                .onChange(of: flightViewModel.deparatureDate, perform: { _ in
                                    calenderId = UUID()
                                })
                                .blendMode(.destinationOver)
                                .padding(.trailing,35)
                                .datePickerStyle(.compact).scaleEffect(x: 1.6,y: 2.8))
                    
                    Divider()
                    
                    if flightViewModel.trip == 0 {
                        Return()
                            .onTapGesture(perform: {
                            flightViewModel.trip = 1
                        })
                    }
                    else{
                        Return() 

                            .overlay (
                            DatePicker("", selection: $flightViewModel.returnDate, in: flightViewModel.deparatureDate..., displayedComponents: [.date])
                                
                                .id(calenderId)
                                .onChange(of: flightViewModel.returnDate, perform: { _ in
                                    calenderId = UUID()
                                })
                                .blendMode(.destinationOver)
                                .padding(.trailing,40).frame(maxWidth: .infinity)
                                .datePickerStyle(.compact)
                                .scaleEffect(x: 1.6,y: 2.8)
                        )
                        
                    }
                    
                    
                }.frame(height: 90)
            }
            Divider()

            VStack {
                HStack {
                    
                    HStack {
                        VStack(alignment: .leading){
                            Text("Traveller")
                                .padding(.bottom,1)
                                .font(.headline)
                                .textCase(.uppercase)
                                .foregroundStyle(Color.gray)
                            //.padding()
                            HStack {
                                  travelerDetails().minimumScaleFactor(0.5)
                                  .lineLimit(2)
                            }
                            .font(.system(size: 15)).bold()
                        }
                        Spacer()
                    }.frame(maxWidth: .infinity)
                    
                        .padding(.leading,20)
                    
                    Divider()
                    HStack {
                        VStack(alignment: .leading){
                            Text("Class").padding(.bottom,1)
                                .font(.headline)
                                .textCase(.uppercase)
                                .foregroundStyle(Color.gray)
                            Text("\(flightViewModel.passengerClass[Int(flightViewModel.sliderValue)])")
                                .minimumScaleFactor(0.7)
                                .font(.system(size: 15))
                                .bold()
                        }
                        Spacer()
                        
                    }.padding(.leading)
                        .frame(maxWidth: .infinity)
                }
                .frame(height: 70)
                
            }.onTapGesture {
                showPop.toggle()
                
            }
            Divider()
            Spacer()
        }
        Spacer()
        
    }
    
    
    func travelerDetails()-> some View{
        let adult = flightViewModel.adult
        let children = flightViewModel.children
        let infant = flightViewModel.infants
        
        var result = ""
        
        if adult == 1 {
            result = result + "\(adult) \(Constants.PopUpPage.adult)"
        }
        else{
            result = result + "\(adult) Adults"
        }
        
        if children != 0{
            if children==1 {
                result = result + ", \(children) Child"
            }
            else{
                result = result + ", \(children) \(Constants.PopUpPage.children)"
            }
        }
        if infant != 0 {
            if infant==1 {
                result = result + ", \(infant) \(Constants.PopUpPage.infant)"
            }
            else{
                result = result + ", \(infant) Infants"
            }
        }
        
        return Text(result)
    }
}

#Preview {
    ContentView()
}


struct Deparature: View {
    @EnvironmentObject var flightViewModel : FlightViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                
                Text("Deparature")
                    .padding(.bottom,1)
                    .font(.system(size: 15)).bold()
                    .textCase(.uppercase)
                    .foregroundStyle(Color.gray)
                HStack {
                    Text(flightViewModel.deparatureDate.formatted(.dateTime.day(.twoDigits)))
                        .font(.system(size: 40))
                        .foregroundStyle(Color.init(red: 0, green: 0, blue: 255))
                    
                    VStack(alignment: .leading) {
                        Text(flightViewModel.deparatureDate.formatted(.dateTime.month()))
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                        Text(flightViewModel.deparatureDate.formatted(.dateTime.weekday(Date.FormatStyle.Symbol.Weekday.wide)))
                            .font(.system(size: 15))
                    }.frame(maxWidth: .infinity)
                    //.border(Color.black)
                }
            }.padding(.leading,20)
                .frame(maxWidth: .infinity)
            //.border(Color.black)
        }.frame(maxWidth: .infinity)
        //.border(Color.black)
        
    }
    
    
}


struct Return: View {
    @EnvironmentObject var flightViewModel : FlightViewModel
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                
                Text("Return")
                    .padding(.bottom,1)
                    .font(.system(size: 15)).bold()
                    .textCase(.uppercase)
                    .foregroundStyle(Color.gray)
                HStack {
                    Text(flightViewModel.returnDate.formatted(.dateTime.day(.twoDigits)))
                        .font(.system(size: 40))
                        .foregroundStyle(Color.init(red: 0, green: 0, blue: 255))
                    
                    VStack(alignment: .leading) {
                        Text(flightViewModel.returnDate.formatted(.dateTime.month()))
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                        Text(flightViewModel.returnDate.formatted(.dateTime.weekday(Date.FormatStyle.Symbol.Weekday.wide)))
                            .font(.system(size: 15))
                    }.frame(maxWidth: .infinity)
                }
            }.padding(.leading)
                .frame(maxWidth: .infinity)
        }.frame(maxWidth: .infinity).frame(maxWidth: .infinity)
            .opacity(flightViewModel.trip ==  0 ? 0.5 : 1)
    }
}



#Preview {
    ContentView()
}

