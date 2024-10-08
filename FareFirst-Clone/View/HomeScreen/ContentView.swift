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
    
    @StateObject var flightViewModel = FlightViewModel.shared
    
    var body : some View {
        
        TabView {
            NavigationStack(path: $flightViewModel.path) {
                FlightViewScreen()
                    .environmentObject(flightViewModel)
                    .navigationDestination(for: NavigationDestions.self) {
                        screen in
                        screen.environmentObject(flightViewModel)
                    }
            }
            .tabItem {
                Text("Flights")
                Image(systemName: Constants.Images.airplane)
            }.tag("Flights")
            
            
            NavigationStack {
                WebView(url: "\(Constants.WebView.self)/hotels")
                
            }
            .tabItem {
                Text("Hotel")
                Image(systemName: Constants.Images.hotel)
            }.tag("Hotel")
            
            NavigationStack {
                WebView(url: "\(Constants.WebView.self)/nomad")
            }
            .tabItem {
                Label("Nomad", systemImage: Constants.Images.nomad)
            }.tag("Hotel")
            
            NavigationStack {
                WebView(url: "\(Constants.WebView.self)/about")
            }
            .tabItem {
                Label("About", systemImage: Constants.Images.about)
            }.tag("Hotel")
        }
    }
    
}





#Preview {
    ContentView()
}







