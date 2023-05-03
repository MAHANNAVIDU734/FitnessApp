import UIKit
import RappleProgressHUD

class StartedScheduleVC: UIViewController {
    
    var currentExerciseSchedule:FirestoreSchedule?
    private var currentOnGoingExerciseInSchedule : FirestoreScheduleExercise?
    private var secondsRemaining :Int = 0
    private var exerciseCountdownTimer:Timer?
    private var scheduleCountdownTimer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    private func getCurrentOnGoingExercise(){
        if let _currentExerciseSchedule = currentExerciseSchedule{
            if(_currentExerciseSchedule.status == StatesForOngoingActivity.Started.rawValue){
                _currentExerciseSchedule.exerciseList.forEach { firestoreScheduleExercise in
                    if ( firestoreScheduleExercise.status == StatesForOngoingActivity.Started.rawValue || firestoreScheduleExercise.status == StatesForOngoingActivity.Idle.rawValue ){
                        currentOnGoingExerciseInSchedule = firestoreScheduleExercise
                        enableStartPauseButtons()
                        bindElapsedTimeOnUi()
                        updateRemainigTimeValues()
                    }else{
                        // continue to next item
                    }
                }
            }else{
                resetCurrentStateOnSchedule()
                // start the exercise from the begining
            }
            
        }
    }
    
    private func updateRemainigTimeValues(){
        
    }
    
    private func bindElapsedTimeOnUi(){
        bindCurrentElapsedExerciseTimeOnUi()
        bindCurrentElapsedScheduleTimeOnUi()
    }
    
    private func bindCurrentElapsedExerciseTimeOnUi(){
        
    }
    
    private func bindCurrentElapsedScheduleTimeOnUi(){
        
    }
    
    private func enableStartPauseButtons(){
        
    }
    
    private func resetCurrentStateOnSchedule(){
        if let _currentExerciseSchedule = currentExerciseSchedule{
            _currentExerciseSchedule.status = StatesForOngoingActivity.Idle.rawValue
            _currentExerciseSchedule.elapsedTime = 0
            _currentExerciseSchedule.exerciseList.forEach { firestoreScheduleExercise in
                firestoreScheduleExercise.elapsedTime = 0
                firestoreScheduleExercise.status = StatesForOngoingActivity.Idle.rawValue
            }
            currentExerciseSchedule = _currentExerciseSchedule
            updateCustomScheduleDataOnFirestore()
        }
    }
    
    private func updateCustomScheduleDataOnFirestore(){
        if let _currentExerciseSchedule = currentExerciseSchedule {
            RappleActivityIndicatorView.startAnimating()
            FirestoreScheduleManager.shared.updaetCustomScheduleOnFirestoreDb(firestoreSchedule: _currentExerciseSchedule) { status, message, data in
                if(status){
                    
                }else{
                    
                }
                RappleActivityIndicatorView.stopAnimation()
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
//    private func handleTimerTick(){
//        if self.secondsRemaining > 0 {
//            //            self.lblTimeOne.text = "\(self.secondsRemaining) seconds"
//            self.secondsRemaining -= 1
//        } else {
//            self.timer?.invalidate()
//        }
//    }
//
//    private func initAndStartTimer(){
//        self.timer =  Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
//            self.handleTimerTick()
//        }
//    }
//
//
//    @IBAction func actionPlay(_ sender: Any) {
//        initAndStartTimer()
//    }
//
//    @IBAction func actionPause(_ sender: Any) {
//        self.timer?.invalidate()
//    }
    
    
}
