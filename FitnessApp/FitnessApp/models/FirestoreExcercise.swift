
import Foundation


struct FirestoreExcercise: Codable
{
    var excerciseId:String
    var exerciseGIFs: [String]
    var exerciseTitle: String
    var exerciseDescription: String
    var targetMuscles: String
    var exerciseEquipments: [String]
    var bmiTargetRange : [Double]
    var duration : Int // in minutes
}
