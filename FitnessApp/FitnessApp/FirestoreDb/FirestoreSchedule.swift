struct FirestoreSchedule: Codable
{
    var scheduleId:String
    var scheduleTitle: String
    var elapsedTime: Int = 0  // milli seconds
    var totalTime: Int = 0  // in  seconds
    var status:String = StatesForOngoingActivity.Idle.rawValue
    var exerciseList : [FirestoreScheduleExercise]? = nil
}
