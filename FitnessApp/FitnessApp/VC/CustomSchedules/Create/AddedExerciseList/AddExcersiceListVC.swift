
import UIKit
import RappleProgressHUD

class AddExcersiceListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectedScheduleTitleLbl: UILabel!
    @IBOutlet weak var placeHolderView: UIStackView!
    var currentSchedule:FirestoreSchedule?
    
    override func viewDidLoad() {
        selectedScheduleTitleLbl.text = currentSchedule?.scheduleTitle
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchScheduleDetailsFromFirestore()
        super.viewWillAppear(animated)
    }
    
    private func fetchScheduleDetailsFromFirestore() {
        RappleActivityIndicatorView.startAnimating()
        guard let _scheduleId = currentSchedule?.scheduleId else { return }
        FirestoreScheduleManager.shared.getScheduleDataFromShceduleIdStoredOnFirestoreDb(scheduleId: _scheduleId) { status, message, data in
            if (status){
                print("ScheduleDetails Fetched******")
                if  let _firestoreSchedule = data as? FirestoreSchedule {
                    self.currentSchedule = _firestoreSchedule
                }
                self.tableView.reloadData()
                RappleActivityIndicatorView.stopAnimation()
            }else{
                RappleActivityIndicatorView.stopAnimation()

            }
        }
    }
    
    
    func navigateToPickExcerciseView(){
        let vc = ApplicationServiceProvider.shared.viewController(in: .Schedule, identifier: "PickExcerciseVC")
        if let _vc = vc as? PickExcerciseVC {
            _vc.firestoreSchedule = currentSchedule
        }
        
        let navigationController: UINavigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.setNavigationBarHidden(true, animated: true)
        present(navigationController, animated: true)
    }
    
    func startSchedule(){
        let vc = ApplicationServiceProvider.shared.viewController(in: .Schedule, identifier: "StartedScheduleVC")
        if let _vc = vc as? StartedScheduleVC {
            _vc.currentSchedule = currentSchedule
        }
        
        let navigationController: UINavigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.setNavigationBarHidden(true, animated: true)
        present(navigationController, animated: true)
    }

    @IBAction func addExcerciceAction(_ sender: Any) {
        navigateToPickExcerciseView()
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func startScheduleAction(_ sender: Any) {
        startSchedule()
    }
}

extension AddExcersiceListVC: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentSchedule?.exerciseList.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddExersiceListTVCell" , for: indexPath)
        if let _cell = cell as? AddExersiceListTVCell {
            if let _model = currentSchedule?.exerciseList {
                _cell.configCell(scheduleExercise: _model[indexPath.row])
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
