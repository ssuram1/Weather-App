//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Shravani on 7/14/24.
// call API to fetch weather of current location

import Foundation
import CoreLocation

class WeatherManager {
    //args of long and lat as CLLocationDegrees(double)
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        //url endpoint to retrieve data; if not present, throw fatal error
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\("007157bf82a555f7809c4f88c12a3ad5")&units=imperial") else {fatalError("Missing URL")}
        //URLRequest object encapsulates information about request
        let urlRequest = URLRequest(url: url)
        //await suspends current function until URLSession is successful
        //URLSession returns tuple with response data and response URL
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        //cast HTTP response and check if successful HTTP request; if not, print error message
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data")}
        
        //decode JSON data into SwiftUI data
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
    }
}

// structure of response received from OpenWeather API(weather data JSON)
struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse

    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }

    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}

extension ResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}
