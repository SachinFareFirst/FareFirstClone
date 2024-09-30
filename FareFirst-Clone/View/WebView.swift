//
//  WebView.swift
//  FareFirst-Clone
//
//  Created by Sachin H K on 30/09/24.
//

//import Foundation
import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    
    
    @State var url : String
    
    func makeUIView(context: Context) -> some UIView {
        
        guard let url = URL(string : url) else {
            return WKWebView()
        }
         let webView = WKWebView(frame: .zero)
         webView.load(URLRequest(url: url))
         return webView
     }
    func updateUIView(_ uiView: UIViewType, context: Context) { }
}
