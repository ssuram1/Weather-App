//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Shravani on 8/7/24.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                //each element spaced out by 5 pixels
                VStack(alignment: .leading, spacing: 5) {
                    //retrieve from preview weather
                    Text(weather.name)
                        .bold().font(.title)
                    //string interpolation with current date and time
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                //space below
                Spacer()
                //
                VStack {
                    
                    HStack{
                        VStack(spacing: 20) {
                            //add icon to match weather conditions
                            Image(systemName:
                                //change icon based on current conditions
                                iconForWeather(weather.weather[0].main))
                            //increase icon size
                                .font(.system(size: 40))
                            //print main weather condition
                            Text(weather.weather[0].main)
                        }
                        .frame(width: 150,
                               alignment: .leading)
                        
                        Spacer()
                        
                        //display temperature
                        Text(weather.main.feels_like
                            .roundDouble() + "°")
                        .font(.system(size: 100))
                        .fontWeight(.bold)
                        .padding()
                    }
                    
                    Spacer()
                        .frame(height: 80)
                    //create image with url
                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                        image
                        //allow to resize according to container/frame
                            .resizable()
                        //scale to fit in container while maintaing aspect ratio
                            .aspectRatio(contentMode: .fit)
                        //set width of image
                            .frame(width: 350)
                        //progress view when downloading image
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
            }
            .padding()
            //fill screen and left edge
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 20){
                    Text("Weather now")
                        .bold().padding(.bottom)
                    //show min and max temps
                    HStack {
                        WeatherRow(logo: "thermometer.low", name: "Min temp", value: (weather.main.temp_min.roundDouble() + "°"))
                        Spacer()
                        WeatherRow(logo: "thermometer.high", name: "Max temp", value: (weather.main.temp_max.roundDouble() + "°"))
                    }
                    //show wind speed and humidity
                    HStack {
                        WeatherRow(logo: "wind", name: "Wind Speed", value: (weather.wind.speed.roundDouble() + "m/s"))
                        Spacer()
                        WeatherRow(logo: "humidity", name: "Humidity", value: (weather.main.humidity.roundDouble() + "%"))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness:0.354))
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        
        //background color covers bottom safe area
        .edgesIgnoringSafeArea(.bottom)
        //same color as ContentView
        .background(Color(hue: 0.656, saturation: 0.787, brightness:0.354))
        .preferredColorScheme(.dark)
    }
    // Function to choose the appropriate icon
    func iconForWeather(_ main: String) -> String {
        switch main {
        case "Clear":
            return "sun.max"
        case "Clouds":
            return "cloud"
        case "Rain":
            return "cloud.rain"
        case "Drizzle":
            return "cloud.drizzle"
        case "Thunderstorm":
            return "cloud.bolt"
        case "Snow":
            return "snow"
        case "Mist", "Smoke", "Haze", "Dust", "Fog", "Sand", "Ash", "Squall", "Tornado":
            return "cloud.fog"
        default:
            return "thermometer.medium"
        }
    }
}

#Preview {
    //create instance of WeatherView to preview with previewWeather
    WeatherView(weather: previewWeather)
}
