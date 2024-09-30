


import Foundation
import SwiftUI

enum NavigationDestions : String , CaseIterable , Hashable ,View {
    case From
    case To
    case OneWaySearchButton
    case TwoWaySearchButton
    
    var body: some View {
        switch self {
        case .From :FromAndToLocation(From: "Origin")//.environmentObject(locationViewModel)
                .navigationTitle("Origin")
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbarBackground(Color.blue,for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar) 
        case .To  : FromAndToLocation(To: "Destination")//.environmentObject(locationViewModel)
                .navigationTitle("Destination")
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbarBackground(Color.blue,for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
        case .OneWaySearchButton :
            
            OneWaySearch()//.environmentObject(locationViewModel)
                .navigationTitle("Origin")
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbarBackground(Color.blue,for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
              
        case .TwoWaySearchButton : TwoWaySearch()//.environmentObject(locationViewModel)
                .navigationTitle("Origin")
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbarBackground(Color.blue,for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}


