
import UIKit

class CreateSchedulePopUpVC: UIViewController {
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var newScheduleTitleTxt: UITextField!
    
    
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
            if _title.isEmpty {
                self.showErrorAlert(messageString: "Schedule Title Required!")
            }else{
                let firestoreSchedule =  FirestoreSchedule(scheduleId: CommonHelpers.randomString(lenth: 12), scheduleTitle: _title)
                self.navigateToSelectExcerciseView(firestoreSchedule:firestoreSchedule )
            }
        }else{
            self.showErrorAlert(messageString: "Schedule Title Required!")
        }
    }
    
    private func showErrorAlert(messageString:String){
        AlertManager.shared.singleActionMessage(title: "Alert", message: messageString, actionButtonTitle: "Ok", vc: self)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    func navigateToSelectExcerciseView(firestoreSchedule:FirestoreSchedule) {
        let vc = ApplicationServiceProvider.shared.viewController(in: .Schedule, identifier: "PickExcerciseVC")
        if let _vc = vc as? PickExcerciseVC {
            _vc.firestoreSchedule = firestoreSchedule
        }
        
        let navigationController: UINavigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.setNavigationBarHidden(true, animated: true)
        present(navigationController, animated: true){
            self.dismiss(animated: true)
        }
    }
}
