//
//  WeatherModel.swift
//  Weather
//
//  Created by Yu on 2022/2/8.
//

import Foundation

struct WeatherModel: Codable {
    let weather: [WeatherObj]
    let main: Main
    let name: String
}

struct WeatherObj: Codable {
    let main:String
    let description:String
    let icon:String
}

struct Main: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
}
