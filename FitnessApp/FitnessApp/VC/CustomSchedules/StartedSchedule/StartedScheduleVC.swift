import UIKit
import RappleProgressHUD

class StartedScheduleVC: UIViewController {
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var startbtn: UIButton!
    @IBOutlet weak var timeCountLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var bodyPartLbl: UILabel!
    @IBOutlet weak var equipmentLbl: UILabel!
    @IBOutlet weak var gitImageView: UIImageView!
    
    private var isPaused:Bool = true
    var currentSchedule:FirestoreSchedule?
    private var currentOnGoingExerciseInSchedule : FirestoreScheduleExercise?
    
    private var secondsRemaining :Int = 0
    private var exerciseCountdownTimer:Timer?
    private var scheduleDataSyncingCountdownTimer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isPaused = !startbtn.isSelected
        updateUI()
        setUpOnGoingExcerciseDetails()
    }
    
    private func setUpOnGoingExcerciseDetails(){
        getCurrentOnGoingExercise()
        if currentOnGoingExerciseInSchedule != nil {
            bindExerciseDetailToUi()
            updateRemainigTimeInitially()
            checkPlayPauseStateAndStartTimers()    
        }
    }
    
    private func bindExerciseDetailToUi(){
      let firestoreExercise =  Constants.exerciseDataOnFirestore?.first(where: { firestoreExcercise in
          firestoreExcercise.excerciseId == currentOnGoingExerciseInSchedule?.excerciseId
        })
        
        gitImageView.kf.setImage(with: URL(string: firestoreExercise?.exerciseGIFs.first ?? ""))
        titleLbl.text = firestoreExercise?.exerciseTitle ?? ""
        descriptionLbl.text = firestoreExercise?.exerciseDescription ?? ""
        bodyPartLbl.text = firestoreExercise?.targetMuscles ?? ""
        let exerciseEquipments = firestoreExercise?.exerciseEquipments.joined(separator: ", ")
        equipmentLbl.text = exerciseEquipments
    }
    
    func updateUI() {
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 20
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        startbtn.layer.borderColor = UIColor(named: "title")?.cgColor
        startbtn.layer.borderWidth = 6
        startbtn.setImage(UIImage(systemName: "arrowtriangle.right.fill"), for: .normal)
        startbtn.setImage(UIImage(systemName: "stop.fill"), for: .selected)
        
    }
    
    private func getCurrentOnGoingExercise(){
        currentOnGoingExerciseInSchedule = nil
        if let _currentExerciseSchedule = currentSchedule{
            if(_currentExerciseSchedule.status == StatesForOngoingActivity.Started.rawValue){
                if  !_currentExerciseSchedule.exerciseList.isEmpty{
                    var isScheduleCompleted = true
                    for firestoreScheduleExercise in  _currentExerciseSchedule.exerciseList{
                        if ( firestoreScheduleExercise.status == StatesForOngoingActivity.Started.rawValue || firestoreScheduleExercise.status == StatesForOngoingActivity.Idle.rawValue ){
                            currentOnGoingExerciseInSchedule = firestoreScheduleExercise
                            isScheduleCompleted = false
                            break
                        }else{
                            continue
                        }
                    }
                    if isScheduleCompleted {
                        handleScheduleCompletion()
                        return
                    }
                    
                }else{
                    self.dismiss(animated: false)
                }
            }else{
                resetCurrentStateOnSchedule()
                startSchuedleFromBegining()
            }
        }else{
            self.dismiss(animated: false)
        }
        
    }
    
    private func handleScheduleCompletion(){
        startbtn.isSelected.toggle()
        resetCurrentStateOnSchedule()
        AlertManager.shared.singleActionMessage(title: "Alert",message:  "Schedule is Completed!" , actionButtonTitle: "Ok", vc: self) { action in
            self.dismiss(animated: true)
        }
    }
    
    private func startSchuedleFromBegining(){
        currentOnGoingExerciseInSchedule = currentSchedule?.exerciseList.first
        currentOnGoingExerciseInSchedule?.status = StatesForOngoingActivity.Started.rawValue
        currentSchedule?.status = StatesForOngoingActivity.Started.rawValue
    }
    
    private func updateRemainigTimeInitially(){
        secondsRemaining = currentOnGoingExerciseInSchedule!.totalTime - currentOnGoingExerciseInSchedule!.elapsedTime
    }
    
    private func updateElapsedTimeOnCurrentExercise(){
        currentOnGoingExerciseInSchedule!.elapsedTime = currentOnGoingExerciseInSchedule!.totalTime - secondsRemaining
    }
    
    private func bindRemainingExerciseTimeOnUi(){
        let remamingTimeInString =   secondsToHoursMinutesSecondsStr(seconds: secondsRemaining)
        timeCountLbl.text = remamingTimeInString
    }
    
    private func resetCurrentStateOnSchedule(){
        if var _currentExerciseSchedule = currentSchedule{
            _currentExerciseSchedule.status = StatesForOngoingActivity.Idle.rawValue
            _currentExerciseSchedule.elapsedTime = 0
            if !_currentExerciseSchedule.exerciseList.isEmpty{
                for var scheduleExerciseList in _currentExerciseSchedule.exerciseList{
                    scheduleExerciseList.elapsedTime = 0
                    scheduleExerciseList.status = StatesForOngoingActivity.Idle.rawValue
                }
                currentSchedule = _currentExerciseSchedule
                syncScheduleDataToFirestore()
            }
        }
    }
    
    private func syncScheduleDataToFirestore(){
        if let _currentExerciseSchedule = currentSchedule {
            FirestoreScheduleManager.shared.updaetCustomScheduleOnFirestoreDb(firestoreSchedule: _currentExerciseSchedule) { status, message, data in
                if(status){
                    
                }else{
                    
                }
            }
        }
    }
    
    @IBAction func prevAction(_ sender: Any) {
        
    }
    @IBAction func startAction(_ sender: Any) {
        startbtn.isSelected.toggle()
        isPaused = !startbtn.isSelected
        checkPlayPauseStateAndStartTimers()
    }
    @IBAction func nextAction(_ sender: Any) {
        
    }
    
    
    private func secondsToHoursMinutesSecondsStr (seconds : Int) -> String {
        let (hours, minutes, seconds) = secondsToHoursMinutesSeconds(seconds: seconds);
        var str = hours > 0 ? "\(hours) h" : ""
        str = minutes > 0 ? str + " \(minutes) min" : str
        str = seconds > 0 ? str + " \(seconds) sec" : str
        return str
    }
    
    private func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    private func calculateRemainingTime(){
        if self.secondsRemaining-1 > 0 {
            self.secondsRemaining -= 1
        } else {
            secondsRemaining = 0
            self.exerciseCountdownTimer?.invalidate()
            self.scheduleDataSyncingCountdownTimer?.invalidate()
        }
    }
    
    private func completeCurrentExercise(){
        currentOnGoingExerciseInSchedule?.elapsedTime = 0
        currentOnGoingExerciseInSchedule?.status = StatesForOngoingActivity.Completed.rawValue
        
        updateScheduleWithCurrentStateOfOnGoingExcercise()
       
        syncScheduleDataToFirestore()
        setUpOnGoingExcerciseDetails()
    }
    
    private func updateScheduleWithCurrentStateOfOnGoingExcercise(){
        if let itemIndex = currentSchedule!.exerciseList.firstIndex(where: {$0.excerciseId == currentOnGoingExerciseInSchedule!.excerciseId}) {
            currentSchedule!.exerciseList[itemIndex] = currentOnGoingExerciseInSchedule!
        }
    }
    
    private func initAndStartTimerForOnGoingExercise(){
        self.exerciseCountdownTimer =  Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            self.caculateTimesOnTick()
            self.bindRemainingExerciseTimeOnUi()
        }
    }
    
    private func initAndStartTimerForSyncDataWithRemote(){
        self.scheduleDataSyncingCountdownTimer =  Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { (Timer) in
            self.syncScheduleDataToFirestore()
        }
    }
    
    private func caculateTimesOnTick(){
        print("secondsRemaining - \(secondsRemaining)")
        calculateRemainingTime()
        
        if secondsRemaining == 0 {
            completeCurrentExercise()
        }else{
            updateElapsedTimeOnCurrentExercise()
            updateScheduleWithCurrentStateOfOnGoingExcercise()
        }
    }
    
    private func checkPlayPauseStateAndStartTimers(){
        if !isPaused{
            initAndStartTimerForOnGoingExercise()
            initAndStartTimerForSyncDataWithRemote()
        }else{
            exerciseCountdownTimer?.invalidate()
            scheduleDataSyncingCountdownTimer?.invalidate()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.exerciseCountdownTimer?.invalidate()
        self.scheduleDataSyncingCountdownTimer?.invalidate()
        super.viewWillDisappear(animated)
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
