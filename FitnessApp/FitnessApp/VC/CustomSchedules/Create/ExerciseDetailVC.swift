
import UIKit

class ExerciseDetailVC: UIViewController {
    
    @IBOutlet weak var exerciseTitleLbl: UILabel!
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var exerciseDescriptionLbl: UILabel!
    @IBOutlet weak var EffectedBodyPartLbl: UILabel!
    @IBOutlet weak var equipmentLbl: UILabel!
    
    var selectedFirestoreExercise:FirestoreExcercise?=nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindExecerciseDetailsToUi()
    }
    
    private func bindExecerciseDetailsToUi(){
        gifImageView.kf.setImage(with: URL(string: selectedFirestoreExercise?.exerciseGIFs.first ?? ""))
        exerciseTitleLbl.text = selectedFirestoreExercise?.exerciseTitle ?? ""
        exerciseDescriptionLbl.text = selectedFirestoreExercise?.exerciseDescription ?? ""
        EffectedBodyPartLbl.text = selectedFirestoreExercise?.targetMuscles ?? ""
        let exerciseEquipments = selectedFirestoreExercise?.exerciseEquipments.joined(separator: ", ")
        equipmentLbl.text = exerciseEquipments
    }
    
    private func closeVc(){
        dismiss(animated: true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
