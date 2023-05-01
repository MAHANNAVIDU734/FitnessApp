
import UIKit
import FirebaseAuth

class LaunchScreenVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIsUserAuthenticatedOnFirebase()
    }
    
    func handleUserNavigation(isUserAuthenticated:Bool){
        DispatchQueue.main.asyncAfter(deadline: (.now() + 5)) {
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
                var firestoreUser =  data as! FirestoreUser
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
