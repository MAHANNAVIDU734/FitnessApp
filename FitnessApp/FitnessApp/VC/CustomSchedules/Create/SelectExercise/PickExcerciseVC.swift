
import UIKit
import RappleProgressHUD

class PickExcerciseVC: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    private var  excerciseList = [FirestoreExcercise]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchExerciseListFromFirestore()
    }
    
    private func fetchExerciseListFromFirestore() {
        RappleActivityIndicatorView.startAnimating()
        FirestoreExcerciseManager.shared.getExerciseDataStoredOnFirestoreDb { status, message, data in
            if (status){
                print("Document Fetched******")
                let excerciseData = data as? [FirestoreExcercise]
                if  let _excerciseData = excerciseData {
                    self.excerciseList.removeAll()
                    Constants.exerciseDataOnFirestore = _excerciseData
                    self.excerciseList.insert(contentsOf: _excerciseData, at: 0)
                }
                self.tableview.reloadData()
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
    
    private func navigateToAddExerciseToShcedule(){
        let vc = ApplicationServiceProvider.shared.viewController(in: .Schedule, identifier: "ExerciseDetailVC")
        UIApplication.topViewController()?.present(vc, animated: true)
    }
    
}

extension PickExcerciseVC: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return excerciseList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutTVCell" , for: indexPath)
        if let _cell = cell as? ExerciseTVCell {
            _cell.config(firestoreExercise:excerciseList[indexPath.row] )
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToAddExerciseToShcedule()
    }
}
