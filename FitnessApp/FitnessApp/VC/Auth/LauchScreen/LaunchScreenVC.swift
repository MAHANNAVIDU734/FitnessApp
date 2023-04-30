
import UIKit
import FirebaseAuth

class LaunchScreenVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //:MARK check user authentication on firebase
    private func checkIsUserAuthenticatedOnFirebase(){
        let currentUser =  Auth.auth().currentUser
        if currentUser != nil {
            Auth.auth().currentUser?.reload(completion: { err in
                if let error = err {
                    AlertManager.shared.singleActionMessage(title: "Alert", message: error.localizedDescription, actionButtonTitle: "Ok", vc: self)
                }else{
                    Constants.currentLoggedInFirebaseAuthUser =  Auth.auth().currentUser
                    //Conitnue to home
                }
            })
        }else{
            //Conitnue to login
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
