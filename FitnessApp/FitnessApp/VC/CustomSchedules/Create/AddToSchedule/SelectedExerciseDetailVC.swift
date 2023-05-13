
import UIKit
import RappleProgressHUD

class SelectedExerciseDetailVC: UIViewController {
    
    @IBOutlet weak var exerciseTitleLbl: UILabel!
    @IBOutlet weak var gifImgView: UIImageView!
    @IBOutlet weak var repCountTxt: UITextField!
    @IBOutlet weak var setCountTxt: UITextField!
    @IBOutlet weak var weightLossTxt: UITextField!
    @IBOutlet weak var exerciseDescriptionLbl: UILabel!
    @IBOutlet weak var EffectedBodyPartLbl: UILabel!
    @IBOutlet weak var equipmentLbl: UILabel!
    
    var selectedFirestoreExercise:FirestoreExcercise?=nil
    var selectedFirestoreSchedule:FirestoreSchedule?=nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindExecerciseDetailsToUi()
    }
    
    private func bindExecerciseDetailsToUi(){
        gifImgView.kf.setImage(with: URL(string: selectedFirestoreExercise?.exerciseGIFs.first ?? ""))
        exerciseTitleLbl.text = selectedFirestoreExercise?.exerciseTitle ?? ""
        exerciseDescriptionLbl.text = selectedFirestoreExercise?.exerciseDescription ?? ""
        EffectedBodyPartLbl.text = selectedFirestoreExercise?.targetMuscles ?? ""
        let exerciseEquipments = selectedFirestoreExercise?.exerciseEquipments.joined(separator: ", ")
        equipmentLbl.text = exerciseEquipments
    }
    
    private func updateFirestoreScheduleExercise(){
        updatedFirestoreScheduleObject()
        
        RappleActivityIndicatorView.startAnimating()
        FirestoreScheduleManager.shared.updaetCustomScheduleOnFirestoreDb(firestoreSchedule: selectedFirestoreSchedule!) { status, message, data in
            if (status){
                print("Schedule Updated******")
                RappleActivityIndicatorView.stopAnimation()
                AlertManager.shared.singleActionMessage(title: "Alert", message:"Added Exercise to Schedule! "  , actionButtonTitle: "Ok", vc: self) { action in
                    UIApplication.topViewController()?.dismiss(animated: true)
                }
            }else{
                RappleActivityIndicatorView.stopAnimation()
                self.showErrorAlert(messageString: "Something Went Wrong..Please Try Again !")
            }
        }
    }
    
    private func getFirestoreScheduleExerciseObject()->FirestoreScheduleExercise?{
        
        let repCountInt =  (Int(repCountTxt.text!) ?? 0)
        let setCountInt =  (Int(setCountTxt.text!) ?? 0)
        let requiredWeight = Double(weightLossTxt.text ?? "0.0") ?? 0.0
        
        let exerciseTimeInMinutes =  (selectedFirestoreExercise?.duration ?? 0)
        
        let totalExerciseTimeInMinutes = (( exerciseTimeInMinutes * repCountInt) * setCountInt)
        let totalExerciseTimeInSeconds = totalExerciseTimeInMinutes * 60
        
        let firestoreScheduleExercise = FirestoreScheduleExercise(excerciseId: selectedFirestoreExercise!.excerciseId, reps: repCountInt, sets: setCountInt, weight:requiredWeight,totalTime: totalExerciseTimeInSeconds, elapsedTime: 0)
        
        return firestoreScheduleExercise
        
    }
    
    private func updatedFirestoreScheduleObject(){
        let  firestoreScheduleExercise =   getFirestoreScheduleExerciseObject()
        selectedFirestoreSchedule?.exerciseList.append(firestoreScheduleExercise!)
        
        let totalScheduleTimeInSeconds =  CommonHelpers.calculateTotalTimeForExerciseInSchedule(firestoreSchedule: selectedFirestoreSchedule!)
        selectedFirestoreSchedule?.totalTime = totalScheduleTimeInSeconds
    }
    
    private func validateForm() -> Bool {
        
        let setCount :String? = setCountTxt.text
        let repCount :String? = repCountTxt.text
        
        guard let _repCount = repCount else {
            showErrorAlert(messageString: "Rep Count Required!")
            return false
        }
        guard !(_repCount.trimLeadingTralingNewlineWhiteSpaces().isEmpty) else {
            showErrorAlert(messageString: "Enter Valid Rep Count !")
            return false
        }
        
        let repCountInt =  (Int(_repCount) ?? 0)
        
        guard ( repCountInt > 0) else {
            showErrorAlert(messageString: "Rep Count Has to be Greater than 0")
            return false
        }
        
        guard let _setCount = setCount else {
            showErrorAlert(messageString: "Set Count Required!")
            return false
        }
        guard !(_setCount.trimLeadingTralingNewlineWhiteSpaces().isEmpty) else {
            showErrorAlert(messageString: "Enter Valid Set Count !")
            return false
        }
        
        let setCountInt =  (Int(_setCount) ?? 0)
        
        
        guard ( setCountInt > 0) else {
            showErrorAlert(messageString: "Set Count Has to be Greater than 0")
            return false
        }
        
        return true
    }
    
    private func showErrorAlert(messageString:String){
        AlertManager.shared.singleActionMessage(title: "Alert", message: messageString, actionButtonTitle: "Ok", vc: self)
    }
    
    @IBAction func addToScheduleAction(_ sender: Any) {
        if(validateForm()){
            updateFirestoreScheduleExercise()
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
