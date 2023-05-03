class FirestoreScheduleExercise: Codable
{
    var excerciseId:String
    var reps: Int
    var sets: Int
    var weight: Int?
    var totalTime: Int // in  seconds
    var elapsedTime: Int  // milli seconds
    var status:String = StatesForOngoingActivity.Idle.rawValue
}
