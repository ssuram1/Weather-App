//
//  WelcomeView.swift
//  WeatherApp
//
//  Created by Shravani on 7/7/24.
//Welcome Screen and request and store user's location

import SwiftUI
import CoreLocationUI
//defines WelcomeView conforming to View protocol
struct WelcomeView: View {
    //creates Location Manager instance and injects into view
    @EnvironmentObject var locationManager: LocationManager
    //computed property returning content of View
    var body: some View {
        VStack {
            //vertical stack with 20 points between child views
            VStack(spacing: 20) {
                //sets main text with bold and title font size
                Text("Welcome to the Weather App")
                    .bold().font(.title)
                //asks user to share location
                Text("Please share your current location to get the weather in your area")
                    .padding()
            }
            //align stack to center
            .multilineTextAlignment(.center)
            //add padding around stack
            .padding()
            //button from CoreLocationUI designed to request location from user and closure to store location
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
        }
        //ensure view takes up max width and height on screen
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
//allows preview of WelcomeView
struct WelcomeView_previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
