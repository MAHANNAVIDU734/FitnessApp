import Foundation

enum Storyboard: String {
    case Auth
    case Main
    
}

enum StatesForOngoingActivity : String{
    case Started
    case Completed
    case Idle
}

enum FirestoreCollections:String{
    case users = "users"
    case excercise = "excercise"
    case schedules = "schedules"
}

enum FirebaseStorageFileCategories:String{
    case users = "users"
}

enum DefaultPlaceHolderLinks:String{
    case user_avatar = "https://firebasestorage.googleapis.com/v0/b/fitnessapp-1cef7.appspot.com/o/default%2Fdefault_user_avatart.png?alt=media&token=4794d83b-53df-4937-ae1d-4d2382110fa0"
}
