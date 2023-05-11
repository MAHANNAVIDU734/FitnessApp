
import UIKit

class ExerciseDetailVC: UIViewController {
    
    @IBOutlet weak var gifImgView: UIImageView!
    @IBOutlet weak var repCountTxt: UITextField!
    @IBOutlet weak var setCountTxt: UITextField!
    @IBOutlet weak var weightLossTxt: UITextField!
    
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
