//
//  ContentView.swift
//  FareFirst-Clone
//
//  Created by Sachin H K on 06/09/24.
//

import SwiftUI
import WebKit
import UIKit
struct ContentView: View {
    @State var selected = "Flights"
    
    
    //@StateObject var flightViewModel : FlightViewModel = FlightViewModel()
    
    @StateObject var resultScreenManager : ResultScreenManager = ResultScreenManager()
    @StateObject var flightViewModel = FlightViewModel.shared
    
    var body : some View {
        
        TabView {
            NavigationStack(path: $flightViewModel.path) {
                HomeScreen()
                    .onAppear(perform: {
                        print( Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String as Any )
                        print( Bundle.main.infoDictionary?["CFBundleVersion"] as? String)
                    })
                    .environmentObject(flightViewModel).environmentObject(resultScreenManager)
                    .navigationDestination(for: NavigationDestions.self) {
                        screen in
                        screen.environmentObject(flightViewModel).environmentObject(resultScreenManager)
                        
                    }
            }
            .tabItem {
                Text("Flights\(flightViewModel.path.count)")
                Image(systemName: "airplane")
            }.tag("Flights")
            
            
            NavigationStack {
                    WebView(url: "https://www.farefirst.com/hotels")

            }
            .tabItem {
            Text("Hotel")
                Image(systemName: "bed.double.fill")
            }.tag("Hotel")
            
            NavigationStack {
                WebView(url: "https://www.farefirst.com/nomad")
                //HomeScreen()
            }
            .tabItem {
           Label("Nomad", systemImage: "multiply")
            }.tag("Hotel")
            
            NavigationStack {
               // HomeScreen()
                WebView(url: "https://www.farefirst.com/about")
            }
            .tabItem {
           Label("About", systemImage: "info.circle")
            }.tag("Hotel")
        }
    }
 
}





#Preview {
    ContentView()
}







