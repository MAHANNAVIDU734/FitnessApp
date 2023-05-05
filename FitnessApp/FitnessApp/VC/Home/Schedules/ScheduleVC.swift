
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
        UIApplication.topViewController()?.present(vc, animated: true)
    }
    @IBAction func addNewScheduleAction(_ sender: Any) {
        presentPopupView()
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
