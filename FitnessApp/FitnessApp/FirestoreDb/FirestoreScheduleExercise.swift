struct FirestoreScheduleExercise: Codable
{
    var excerciseId:String
    var reps: Int
    var sets: Int
    var weight: Double = 0.0
    var totalTime: Int // in  seconds
    var elapsedTime: Int  //  seconds
    var status:String = StatesForOngoingActivity.Idle.rawValue
}
