//
//  ContentView.swift
//  WeatherApp
//
//  Created by Shravani on 6/30/24.
// displays user's coordinates after retrieving

import SwiftUI

struct ContentView: View {
    //create LocationManager instance
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    //response body is optional if no response
    //when weather var changes, update view
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            //sharing location is optional so only display if given
            if let location = locationManager.location {
                //check if weather data recieved as ResponseBody type
                if let weather = weather {
                    WeatherView(weather: weather)
                }
                //if not, get coordinates asynchronously
                else {
                    LoadingView()
                        .task{
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
            } else {
                //if still fetching coordinates, show progressView
                if locationManager.isLoading {
                    LoadingView()
                }
                //if denied coordinates, display WelcomeView
                else {
                    //provide to all descendant view of WelcomeView()
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(Color(hue: 0.656, saturation: 0.787, brightness:0.354))
        .preferredColorScheme(.dark)
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
