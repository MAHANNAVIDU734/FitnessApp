class FirestoreSchedule: Codable
{
    var scheduleId:String
    var exerciseGIFs: [String]
    var scheduleTitle: String
    var elapsedTime: Int  // milli seconds
    var totalTime: Int // in  seconds
    var status:String = StatesForOngoingActivity.Idle.rawValue
    var exerciseList : [FirestoreScheduleExercise]
}
