
import Foundation
import SwiftUI

struct OneWaySearch : View {
    @EnvironmentObject var flightViewModel : FlightViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {

        if flightViewModel.isLoading {
            ProgressView("Loading Your Search ").progressViewStyle(CircularProgressViewStyle(tint: Color.black))
                .padding()
                .controlSize(.large)
        }

            ScrollView {
                ForEach(flightViewModel.oneWayResult) {
                    value in
                    VStack {
            
                        HStack(spacing:0) {
                            
                            Text(value.price?.symbol ?? "$")
                            Text("\(value.price?.amount ?? 0)")
                            Spacer()
                            Text("via \(value.gate?.name ?? "ota")" )
                            
                        }.padding(.all,5)
                        Divider()
                            .frame(maxWidth: .infinity-60)
                            
                        HStack {
                            Spacer()
                            AsyncImage(url: URL(string: value.from?.airlineLogoUrl ?? "airplane")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }.padding(.bottom,6)
                            .frame(width: 50, height: 50)
                            Spacer()
                            VStack (alignment : .center){
                                Text(value.from?.time ?? "0:0")
                                Text(value.from?.iata ?? "IXE")
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
                            VStack(alignment : .leading) {
                                Text(value.to?.time ?? "0:0")
                                Text(value.to?.iata ?? "BLR")
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
                        flightViewModel.oneWayResult = []
                        dismiss()
                    }) {
                        Image(systemName: "chevron.backward").bold()
                        Text("Back")
                    }
                  
                }
            }

    }
       
    
    
}

#Preview {
    ContentView()
}
