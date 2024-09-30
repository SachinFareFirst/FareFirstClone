//
//  Trip.swift
//  FareFirst-Clone
//
//  Created by Sachin H K on 07/09/24.
//

import SwiftUI

struct Trip: View {
    @EnvironmentObject var flightViewModel : FlightViewModel
    private let ways = ["One way", "Two way", "Multi city"]
    var body: some View {
        VStack {
            Image("farefirst-white")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70)
                .padding(.top,70)
                
            HStack {
                ForEach(ways.indices, id: \.self) { index in
                    Button(action: {
                        self.flightViewModel.trip = index
                    }, label: {
                        Text(ways[index])
                            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                            .background(Capsule().fill(flightViewModel.trip == index ? Color.white : Color.clear) )
                            .foregroundStyle( flightViewModel.trip == index ? .blue : .white)
                    })
                }
            }.padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                .background(Capsule().stroke(Color.white, lineWidth:1))
            
            
            
            
        }
    }
}

#Preview {
    ContentView()
}





