
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
                    NavigationLink(value:NavigationDestions.WebViewLink)  {
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
                                AsyncImage(url: URL(string: value.from?.airlineLogoUrl ?? Constants.Images.airplane)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }.padding(.bottom,6)
                                .frame(width: 50, height: 50)
                                Spacer()
                                VStack (alignment : .trailing){
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
                        }
                    }.background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemBackground)))
                        .foregroundStyle(Color.black)
                    .padding(.all,10)
                }
              
            } 
            .alert("Error", isPresented: $flightViewModel.resultsAlert, actions: {
                Button("Ok") {
                    flightViewModel.path = NavigationPath()
                }
            }, message: {
                Text("Result not found")
                
            })
            .background(Color(.systemGray3).opacity(0.3))
            .navigationTitle("\(flightViewModel.fromLocation.iataCode ?? "IXE") - \(flightViewModel.toLocation.iataCode ?? "BLR"), \(flightViewModel.deparatureDate.formatted(.dateTime.month().day()))")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        flightViewModel.oneWayResult = []
                        dismiss()
                    }) {
                        Image(systemName: Constants.Images.chevron_backward).bold()
                        Text("Back")
                    }
                  
                }
            }

    }
       
   
    
}

#Preview {
    ContentView()
}
