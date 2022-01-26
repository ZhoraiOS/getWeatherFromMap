//
//  Places.swift
//  getWeather
//
//  Created by Zhora Babkahanyan on 26.01.22.


import Foundation
import CoreLocation

struct Places {
    let latitude : Double
    let longitude : Double
    init(latitude lat : Double, longitude  lon : Double){
        latitude = lat
        longitude = lon
    }
}

struct DefaultPlaces {
    let places = [
        Places(latitude: 40.1811, longitude: 44.5136), //yerevan
        Places(latitude: 55.751244, longitude: 37.618423), //Moscow
        Places(latitude: 48.864716, longitude: 2.349014), //Paris
        Places(latitude: 151.2073, longitude: -33.8679), //Sydney
        Places(latitude: 52.2298, longitude: 21.0118), //Warsaw
        Places(latitude: 4.6097, longitude: -74.0817), //Bogota
        Places(latitude: 34.0522, longitude: -118.2437), //Los Angeles
        Places(latitude: 40.7143, longitude: -74.006), // New York
        Places(latitude: 49.2497, longitude: -123.1193) //Vancouver
    ]
}
