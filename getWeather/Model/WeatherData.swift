//
//  WeatherData.swift
//  getWeather
//
//  Created by Zhora Babkahanyan on 26.01.22.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather : [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
}
