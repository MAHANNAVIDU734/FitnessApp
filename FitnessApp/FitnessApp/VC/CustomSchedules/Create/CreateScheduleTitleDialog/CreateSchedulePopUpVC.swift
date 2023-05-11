
import UIKit

class CreateSchedulePopUpVC: UIViewController {

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
        if let _title = newScheduleTitleTxt.text?.trimLeadingTralingNewlineWhiteSpaces(){
            callBack?(!_title.isEmpty, _title)
        }else{
            callBack?(false, nil)
        }
        
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        ApplicationServiceProvider.shared.manageUserDirection(isUserAuthenticated: true)
    }
}
