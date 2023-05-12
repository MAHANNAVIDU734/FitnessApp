
import UIKit
import RappleProgressHUD

class ScheduleVC: UIViewController {
    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private var  firestoreScheduleList = [FirestoreSchedule]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchScheduleListFromFirestore()
    }
    
    func setupView() {
        buttonView.layer.cornerRadius = 30
    }
    
    func presentEnterScheduleTitlePopupView() {
        let vc = ApplicationServiceProvider.shared.viewController(in: .Schedule, identifier: "CreateSchedulePopUpVC")
        if let _vc = vc as? CreateSchedulePopUpVC {
            _vc.callBack = { status, message in
                if status {
                    self.navigateToSelectExcerciseView()
                }else{
                    self.showErrorAlert(messageString: "Schedule Title Required!")
                }
                
            }
        }
        UIApplication.topViewController()?.present(vc, animated: true)
    }
    
    func navigateToSelectExcerciseView() {
        let vc = ApplicationServiceProvider.shared.viewController(in: .Schedule, identifier: "StartedScheduleVC")
        UIApplication.topViewController()?.present(vc, animated: true)
    }
    
    @IBAction func addNewScheduleAction(_ sender: Any) {
//        presentEnterScheduleTitlePopupView()
        navigateToSelectExcerciseView()
    }
    
    private func fetchScheduleListFromFirestore() {
        RappleActivityIndicatorView.startAnimating()
        FirestoreScheduleManager.shared.getScheduleDataStoredOnFirestoreDb { status, message, data in
            if (status){
                print("Schedule List Fetched******")
                let firestoreScheduleData = data as? [FirestoreSchedule]
                if  let _firestoreScheduleData = firestoreScheduleData {
                    self.firestoreScheduleList.removeAll()
                    self.firestoreScheduleList.insert(contentsOf: _firestoreScheduleData, at: 0)
                }
                self.tableView.reloadData()
                RappleActivityIndicatorView.stopAnimation()
            }else{
                RappleActivityIndicatorView.stopAnimation()
                self.showErrorAlert(messageString: "Something Went Wrong..Please Try Again !")
            }
        }
    }
    
    private func showErrorAlert(messageString:String){
        AlertManager.shared.singleActionMessage(title: "Alert", message: messageString, actionButtonTitle: "Ok", vc: self)
    }
}

extension ScheduleVC: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firestoreScheduleList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SchedulTVCell" , for: indexPath)
        if let _cell = cell as? SchedulTVCell {
            _cell.configCell(firestoreSchedule: firestoreScheduleList[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
