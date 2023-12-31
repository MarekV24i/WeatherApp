//
//  AppError.swift
//  WeatherApp
//
//  Created by Marek on 14.10.2023.
//

// Application level errors
public enum AppError: Error {

    case citySearchFailed
    case conditionsLoadFailed
    case requestCancelled
}
