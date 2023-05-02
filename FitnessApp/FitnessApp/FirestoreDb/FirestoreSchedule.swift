struct FirestoreSchedule: Codable
{
    var scheduleId:String
    var exerciseGIFs: [String]
    var scheduleTitle: String
    var elapsedTime: Int  // milli seconds
    var startedAt: String
    var isCompleted: Bool = false
    var isStarted: Bool = false
    var exerciseList : [FirestoreScheduleExercise]
}
