//
//  CommonHelpers.swift
//  FitnessApp
//
//  Created by AdminProject on 2023-04-30.
//

import Foundation


class CommonHelpers {
    
    static func generateFilePathForFirebaseStorage(fileCategory:FirebaseStorageFileCategories)->String{
        let ramdomImageId = randomString(lenth: 12)
        let imageName = ramdomImageId + ".png"
        return "/"+fileCategory.rawValue+"/" + imageName
    }
    
    static  func randomString(lenth: Int) -> String {
        let letter = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...lenth).map{_ in letter.randomElement()!})
    }
    
    static func calculateBMIValue(height:Double?,weight:Double?) -> Double?{
        if let _height = height ,let  _weight = weight {
            return (  _weight / (_height * _height))
        }else{
            return   0.0
        }
    }
}
