
import UIKit

class SelectedExerciseDetailVC: UIViewController {

    @IBOutlet weak var gifImgView: UIImageView!
    @IBOutlet weak var repCountTxt: UITextField!
    @IBOutlet weak var setCountTxt: UITextField!
    @IBOutlet weak var weightLossTxt: UITextField!
    @IBOutlet weak var exerciseDescriptionLbl: UILabel!
    @IBOutlet weak var EffectedBodyPartLbl: UILabel!
    @IBOutlet weak var equipmentLbl: UILabel!
    
    var selectedFirestoreExercise:FirestoreExcercise?=nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindExecerciseDetailsToUi()
    }
    
    private func bindExecerciseDetailsToUi(){
        gifImgView.kf.setImage(with: URL(string: selectedFirestoreExercise?.exerciseGIFs.first ?? ""))
    }
    
    @IBAction func addToScheduleAction(_ sender: Any) {
    }
}
