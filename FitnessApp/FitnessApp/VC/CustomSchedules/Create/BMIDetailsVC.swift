import UIKit
import RappleProgressHUD

class BMIDetailsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var BmiValueLbl: UILabel!
    
    private var  excerciseListRelatedToBMIValue = [FirestoreExcercise]()
    private var bmiValue:Double =  0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bindBMIvalueToUi()
        super.viewWillAppear(animated)
    }
    
    private func bindBMIvalueToUi(){
        let bmiValue =   calculateBMI()
        BmiValueLbl.text = bmiValue
    }
    
    private func calculateBMI()->String{
        if  let _weight = Constants.currentLoggedInFireStoreUser?.weight {
            if let _height = Constants.currentLoggedInFireStoreUser?.height {
                bmiValue  = _weight / (_height * _height)
                return String(format: "%.2f", bmiValue)
            }else{
                return "0.0"
            }
        }else{
            return "0.0"
        }
    }
    
    private func fetchExerciseListFromFirestore() {
        RappleActivityIndicatorView.startAnimating()
        FirestoreExcerciseManager.shared.getExerciseDataStoredOnFirestoreDb { status, message, data in
            if (status){
                print("Document Fetched******")
                let excerciseData = data as? [FirestoreExcercise]
                if  let _excerciseData = excerciseData {
                    self.excerciseListRelatedToBMIValue.removeAll()
                    Constants.exerciseDataOnFirestore = _excerciseData
                }
                self.tableView.reloadData()
                RappleActivityIndicatorView.stopAnimation()
            }else{
                RappleActivityIndicatorView.stopAnimation()
                self.showErrorAlert(messageString: "Something Went Wrong..Please Try Again !")
            }
        }
    }
    
    private func filterExcerciseDataForBMIValue(){
        if let exerciseList = Constants.exerciseDataOnFirestore {
            exerciseList.forEach { firestoreExcercise in
             let _bmiStart =   firestoreExcercise.bmiTargetRange.first!
             let _bmiEnd =   firestoreExcercise.bmiTargetRange.last!
                if bmiValue >= _bmiStart && bmiValue <= _bmiEnd {
                    excerciseListRelatedToBMIValue.append(firestoreExcercise)
                }
            }
        }
    }
    
    private func showErrorAlert(messageString:String){
        AlertManager.shared.singleActionMessage(title: "Alert", message: messageString, actionButtonTitle: "Ok", vc: self)
    }
}

extension BMIDetailsVC: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return excerciseListRelatedToBMIValue.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutTVCell" , for: indexPath)
        if let _cell = cell as? ExerciseTVCell {
            _cell.config(firestoreExercise:excerciseListRelatedToBMIValue[indexPath.row] )
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
