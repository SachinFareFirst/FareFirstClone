//
//  TwoWaySearch.swift
//  FareFirst-Clone
//
//  Created by Sachin H K on 27/09/24.
//

import Foundation
import SwiftUI

struct TwoWaySearch:View {
    @EnvironmentObject var flightViewModel : FlightViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        if flightViewModel.isLoading {
            ProgressView("Loading Your Search ").progressViewStyle(CircularProgressViewStyle(tint: Color.black))
                .padding()
                .controlSize(.large)
        }
        
        ScrollView {
            ForEach(flightViewModel.twoWayResult) {
                value in
                
                VStack {
                    

                    HStack(spacing:0) {

                        Text(value.price?.symbol ?? "$")
                        Text("\(value.price?.amount ?? 0)")
                        Spacer()
                        Text("via \(value.gate?.name ?? "ota")" )

                    }.padding(.all,5)
                    Divider()
                        .frame(maxWidth: .infinity)
                    HStack {
                        Spacer()
                        AsyncImage(url: URL(string: value.f_data?[0].from?.airlineLogoUrl ?? "airplane")) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }.padding(.bottom,6)
                            .frame(width: 50, height: 50)
                        Spacer()
                        VStack(alignment : .trailing) {
                            Text(value.f_data?[0].from?.time ?? "0:0")
                            Text(value.f_data?[0].from?.iata ?? "IXE")
                        }
                        Spacer()
                        VStack {
                            Divider().frame(width: 80).overlay(.gray)
                            HStack {
                                Text("\(value.total_duration?.h ?? "00:00 h")h")
                                Text("\(value.total_duration?.m ?? "00:00 m")m")
                            }
                            
                        }
                        Spacer()
                        VStack(alignment : .leading)  {
                            Text(value.f_data?[0].to?.time ?? "0:0")
                            Text(value.f_data?[0].to?.iata ?? "BLR")
                        }
                        Spacer()
                        
                    }.padding(.all,5)
                    
                                          
                    
                                            HStack {
                                                Spacer()
                                                AsyncImage(url: URL(string: value.f_data?[1].from?.airlineLogoUrl ?? "airplane")) { image in
                                                    image.resizable()
                                                } placeholder: {
                                                    Image("defaultPlane").resizable().frame(width: 60, height: 60)
                                                }.padding(.bottom,6)
                                                .frame(width: 50, height: 50)
                                                Spacer()
                                                VStack (alignment : .trailing){
                                                    Text(value.f_data?[1].from?.time ?? "0:0")
                                                    Text(value.f_data?[1].from?.iata ?? "IXE")
                                                }
                                                Spacer()
                                                VStack {
                                                    Divider().frame(width: 80).overlay(.gray)
                                                    HStack {
                                                        Text("\(value.total_duration?.h ?? "00:00 h")h")
                                                        Text("\(value.total_duration?.m ?? "00:00 m")m")
                                                    }
                    
                                                }
                                                Spacer()
                                                VStack (alignment : .leading){
                                                    Text(value.f_data?[1].to?.time ?? "0:0")
                                                    Text(value.f_data?[1].to?.iata ?? "BLR")
                                                }
                                                Spacer()
                    
                                            }.padding(.all,5)
                                        }.background(RoundedRectangle(cornerRadius: 5).fill(Color(.systemBackground)))
                                            //.border(Color.black)
                                            .padding(.all,10)
                                            .shadow(radius: 1)
                                    }
                    
                } .navigationTitle("\(flightViewModel.fromLocation.iataCode ?? "IXE") - \(flightViewModel.toLocation.iataCode ?? "BLR"), \(flightViewModel.deparatureDate.formatted(.dateTime.month().day()))")
                    .toolbarColorScheme(.dark, for: .navigationBar)
                    .toolbarBackground(Color.blue,for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .navigationBarBackButtonHidden(true)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                flightViewModel.twoWayResult = []
                                dismiss()
                            }) {
                                Image(systemName: "chevron.backward").bold()
                                Text("Back")
                            }
                            
                        }
                    }
                
            }
            
        }
//    }
//}
//#Preview {
//    TwoWaySearch(flightViewModel: FlightViewModel())
//}
