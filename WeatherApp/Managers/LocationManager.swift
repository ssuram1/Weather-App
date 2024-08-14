//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Shravani on 6/30/24.
// finds user's location/coordinates

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    //create new instance of CLLocationManager
    let manager = CLLocationManager()
    //stores user's location-optional if user denies
    //published because when location changes, must trigger view update
    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading = false
   
    //override default initializer of NSObject
    override init() {
        //call initializer of NSObject
        super.init()
        //LocationManager instance is delegate of manager and receives location updates from manager
        manager.delegate = self
    }
    
    //determine current location
    func requestLocation() {
        //loading location
        isLoading = true
        //find current location
        manager.requestLocation()
    }
    
    //parameters are manager and array of CLLocation objects stored in didUpdatelocations(external name)/locations(internal name)
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //assign location to locations array and retrieve first; check if null
        location = locations.first?.coordinate
        //location retrieved so not loading
        isLoading = false
    }
   
    //handle errors
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location", error)
        isLoading = false
    }
}


