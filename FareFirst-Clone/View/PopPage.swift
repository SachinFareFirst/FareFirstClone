
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
                    if flightViewModel.totalPassengers < 10 {
                        flightViewModel.toastText = false
                    }
                    print("flight",flightViewModel.totalPassengers)
                    minusButton()
                } label: {
                    Image(systemName: Constants.Images.minus_sign
                    )
                    .resizable()
                    .frame(width: 30,height: 30)
                    
                }.disabled(flightViewModel.disableMinusButton(stringValue: passengers)).frame(maxWidth: .infinity)
                
                Spacer()
                
                Text("\(flightViewModel.getCount(stringValue: passengers))")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.gray)
                    .padding()
                Spacer()
                
                Button {
                    if flightViewModel.totalPassengers == 8 {
                        flightViewModel.toastText = true
                    }
                 
                    plusButton()
                    
                } label: {
                    Image(systemName: Constants.Images.plus_sign)
                        .resizable()
                        .frame(width: 30,height: 30)
                    
                    
                }
                .disabled((flightViewModel.disablePlusButton(stringValue: passengers)))
                .frame(maxWidth: .infinity)
            }.frame(maxWidth: 200)
            
            
        }
        .padding()
    }
    
    func plusButton() {
        if passengers == Constants.PopUpPage.adult{
            print(flightViewModel.adult)
            flightViewModel.adult += 1
            
        }
        
        if passengers == Constants.PopUpPage.children{
            flightViewModel.children += 1
            
        }
        if passengers == Constants.PopUpPage.infant{
            
            if flightViewModel.adult > flightViewModel.infants{
                print(flightViewModel.infants)
                flightViewModel.infants += 1
            }
            
        }
    }
    func minusButton() {
        if passengers == Constants.PopUpPage.adult{
            flightViewModel.adult -= 1
            if flightViewModel.infants >= flightViewModel.adult{
                //print("gg",flightViewModel.infants)
                flightViewModel.infants -= 1
            }
        }
        
        if passengers == Constants.PopUpPage.children{
            flightViewModel.children -= 1
            
        }
        
        if passengers == Constants.PopUpPage.infant{
            //print(flightViewModel.infants)
            flightViewModel.infants -= 1
            
        }
    }
    
    
}
