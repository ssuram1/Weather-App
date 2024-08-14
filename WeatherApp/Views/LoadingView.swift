//
//  LoadingView.swift
//  WeatherApp
//
//  Created by Shravani on 7/11/24.
// Shows progress when finding user's location

import SwiftUI

struct LoadingView: View {
    var body: some View {
        //shows progress when fetching location
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .tint(.white)
            //stretches out to entire screen
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LoadingView_Preview: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
