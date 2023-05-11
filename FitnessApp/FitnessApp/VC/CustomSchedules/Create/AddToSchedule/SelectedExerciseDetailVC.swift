
import UIKit

class SelectedExerciseDetailVC: UIViewController {

    @IBOutlet weak var gifImgView: UIImageView!
    @IBOutlet weak var repCountTxt: UITextField!
    @IBOutlet weak var setCountTxt: UITextField!
    @IBOutlet weak var weightLossTxt: UITextField!
    @IBOutlet weak var exerciseDescriptionLbl: UILabel!
    @IBOutlet weak var EffectedBodyPartLbl: UILabel!
    @IBOutlet weak var equipmentLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addToScheduleAction(_ sender: Any) {
    }
}
