//
//  Excercise.swift
//  FitnessApp
//
//  Created by AdminProject on 2023-04-30.
//

import Foundation


struct Exercise: Codable
{
    var excerciseId:String
    var exerciseGIFs: [String]
    var exerciseTitle: String
    var exerciseDescription: String
    var targetMuscles: [String]
    var exerciseEquipments: [String]
    var bmiTargetRangeStartsFrom : Double
    var bmiTargetRangeEndsAt : Double
}
