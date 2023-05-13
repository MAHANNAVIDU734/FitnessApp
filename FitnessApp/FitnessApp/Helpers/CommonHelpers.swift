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
    
    static func calculateTotalTimeForExerciseInSchedule(firestoreSchedule:FirestoreSchedule)-> Int{
        var totlaTime = 0
        if !firestoreSchedule.exerciseList.isEmpty {
            for  firestoreScheduleExercise in firestoreSchedule.exerciseList{
                totlaTime += firestoreScheduleExercise.totalTime
            }
        }
        return totlaTime
    }
    
    static func calculateTotalTimeForSchedule(firestoreSchedule:FirestoreSchedule)-> Int{
        var totalTimeForScheduleInSeconds = 0
        firestoreSchedule.exerciseList.forEach { firestoreScheduleExercise in
            totalTimeForScheduleInSeconds += firestoreScheduleExercise.totalTime
        }
        return totalTimeForScheduleInSeconds
    }
}
