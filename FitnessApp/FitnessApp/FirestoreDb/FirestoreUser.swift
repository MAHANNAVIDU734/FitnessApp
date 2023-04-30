import Foundation


struct FirestoreUser: Codable {
    var id:String
    var fName: String
    var phone: String
    var avatarUrl: String
    var weight:Double?
    var height:Double?
    var fitnessGoal:String?
    var age:Int?
}
