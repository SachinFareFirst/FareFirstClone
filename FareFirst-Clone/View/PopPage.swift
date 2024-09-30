
import SwiftUI
struct PopPage: View {
    @EnvironmentObject var flightViewModel : FlightViewModel
    
    var passengers : String
    var year : String
    
    
    var body: some View {
        
        HStack {
            //Spacer()
            VStack(alignment: .leading,spacing: 5) {
                
                Text("\(passengers)").font(.system(size: 14)).foregroundStyle(Color.gray).fontWeight(.semibold)
                
                Text(year).font(.system(size: 12)).foregroundStyle(Color.gray).fontWeight(.regular)
                
            }
            
            Spacer()
            
            HStack {
                Spacer()
                Button {
                    
                    minusButton()
                } label: {
                    Image(systemName: "minus"
                    ).bold()
                        .padding(20)
                        .frame(maxWidth: 30,maxHeight: 30)
                        .background(.clear)
                        .border(Color.blue)
                        .bold()
                    
                }.disabled(flightViewModel.disableMinusButton(stringValue: passengers)).frame(maxWidth: .infinity)
                
                Spacer()
                
                Text("\(flightViewModel.getCount(stringValue: passengers))")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.gray)
                    .padding()
                Spacer()
                
                Button {
                    
                    plusButton()
                    
                } label: {
                    Image(systemName: "plus")
                        .padding(20)
                        .frame(maxWidth: 30,maxHeight: 30)
                        .background(.clear)
                        .border(Color.blue)
                        .bold()
                    
                }
                .disabled((flightViewModel.totalPassengers == 9))
                .frame(maxWidth: .infinity)
            }.frame(maxWidth: 200)
            
            
        }
        .padding()
    }
    
    func plusButton() {
        if passengers == "Adult"{
            print(flightViewModel.adult)
            flightViewModel.adult += 1
            
        }
        
        if passengers == "Children"{
            flightViewModel.children += 1
            
        }
        if passengers == "Infant"{
            
            if flightViewModel.adult > flightViewModel.infants{
                print(flightViewModel.infants)
                flightViewModel.infants += 1
            }
            
        }
    }
    func minusButton() {
        if passengers == "Adult"{
            flightViewModel.adult -= 1
        }
        
        if passengers == "Children"{
            flightViewModel.children -= 1
            
        }
        if passengers == "Infant"{
            print(flightViewModel.infants)
            flightViewModel.infants -= 1
            
        }
    }
    
    
}
