
import UIKit
import FirebaseAuth

class LaunchScreenVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchExerciseDataAndCache()
    }
    
    func handleUserNavigation(isUserAuthenticated:Bool){
        DispatchQueue.main.asyncAfter(deadline: (.now() + 2)) {
            ApplicationServiceProvider.shared.manageUserDirection(isUserAuthenticated: isUserAuthenticated)
        }
    }
    
    //:MARK check user authentication on firebase
    private func checkIsUserAuthenticatedOnFirebase(){
        let currentUser =  Auth.auth().currentUser
        if currentUser != nil {
            Auth.auth().currentUser?.reload(completion: { err in
                if let error = err {
                    AlertManager.shared.singleActionMessage(title: "Alert", message:error.localizedDescription , actionButtonTitle: "Ok", vc: self) { action in
                        self.handleUserNavigation(isUserAuthenticated: false)
                    }
                }else{
                    Constants.currentLoggedInFirebaseAuthUser =  Auth.auth().currentUser
                    self.fetchFirestoreUser(firebaseUser:  Auth.auth().currentUser!)
                }
            })
        }else{
            handleUserNavigation(isUserAuthenticated: false)
        }
    }
    
    private func fetchFirestoreUser(firebaseUser:User){
        FirestoreUserManager.shared.getUserDetailsStoredOnFirestoreDb(firebaseUser:firebaseUser) { status, message, data in
            if (status){
                let firestoreUser =  data as! FirestoreUser
                Constants.currentLoggedInFireStoreUser = firestoreUser
                self.handleUserNavigation(isUserAuthenticated: true)
            }else{
                self.showErrorAlert(messageString: message!)
            }
        }
    }
    
    private func showErrorAlert(messageString:String){
        AlertManager.shared.singleActionMessage(title: "Alert", message: messageString, actionButtonTitle: "Ok", vc: self)
    }
    
    private func fetchExerciseDataAndCache(){
        FirestoreExcerciseManager.shared.getExerciseDataStoredOnFirestoreDb { status, message, data in
            if (status){
                let excerciseData = data as? [FirestoreExcercise]
                if  let _excerciseData = excerciseData {
                    Constants.exerciseDataOnFirestore = _excerciseData
                }
                self.checkIsUserAuthenticatedOnFirebase()
            }else {
                self.showErrorAlert(messageString: "Something Went Wrong..Please Try Again !")
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
