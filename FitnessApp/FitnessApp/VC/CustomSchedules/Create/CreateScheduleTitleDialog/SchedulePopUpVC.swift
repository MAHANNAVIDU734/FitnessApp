
import UIKit

class SchedulePopUpVC: UIViewController {

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var newScheduleTitleTxt: UITextField!
    
    var callBack: ActionHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        cancelBtn.layer.cornerRadius = 10
        createBtn.layer.cornerRadius = 10
    }
    
    @IBAction func createAction(_ sender: Any) {
        callBack?(true, "")
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        ApplicationServiceProvider.shared.manageUserDirection(isUserAuthenticated: true)
    }
}
