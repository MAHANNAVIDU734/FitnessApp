
import UIKit

class ScheduleVC: UIViewController {
    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        buttonView.layer.cornerRadius = 30
    }
    func presentPopupView() {
        let vc = ApplicationServiceProvider.shared.viewController(in: .Schedule, identifier: "SchedulePopUpVC")
        if let _vc = vc as? SchedulePopUpVC {
            _vc.callBack = { status, message in
                self.navigateToMyExcerciseView()
            }
        }
        UIApplication.topViewController()?.present(vc, animated: true)
    }
    func navigateToMyExcerciseView() {
        let vc = ApplicationServiceProvider.shared.viewController(in: .Schedule, identifier: "MyExcercieVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func addNewScheduleAction(_ sender: Any) {
//        presentPopupView()
        let vc = ApplicationServiceProvider.shared.viewController(in: .Schedule, identifier: "PickExcerciseVC")
        UIApplication.topViewController()?.present(vc, animated: true)
    }
}

extension ScheduleVC: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SchedulTVCell" , for: indexPath)
        if let _cell = cell as? SchedulTVCell {
            _cell.configCell()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
