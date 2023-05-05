
import UIKit

class SchedulePopUpVC: UIViewController {

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var createBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        cancelBtn.layer.cornerRadius = 10
        createBtn.layer.cornerRadius = 10
    }
    
    @IBAction func createAction(_ sender: Any) {
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        ApplicationServiceProvider.shared.manageUserDirection(isUserAuthenticated: true)
    }
}
