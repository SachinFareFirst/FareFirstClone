


import Foundation
import SwiftUI

enum NavigationDestions : String , CaseIterable , Hashable ,View {
    case From
    case To
    case OneWaySearchButton
    case TwoWaySearchButton
    case WebViewLink
    
    var body: some View {
        switch self {
        case .From :FromAndToLocation(From: Constants.TitleBar.origin)//.environmentObject(locationViewModel)
                .navigationTitle(Constants.TitleBar.origin)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbarBackground(Color.blue,for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar) 
        case .To  : FromAndToLocation(To: Constants.TitleBar.destination)//.environmentObject(locationViewModel)
                .navigationTitle(Constants.TitleBar.destination)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbarBackground(Color.blue,for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
        case .OneWaySearchButton :
            
            OneWaySearch()//.environmentObject(locationViewModel)
               
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbarBackground(Color.blue,for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
              
        case .TwoWaySearchButton : TwoWaySearch()//.environmentObject(locationViewModel)
                
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbarBackground(Color.blue,for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
        case .WebViewLink :
            WebView(url:"https://www.farefirst.com")
        }
    }
}


