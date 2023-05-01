import UIKit
import FirebaseAuth
import RappleProgressHUD

class SignInScreenVC: UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
//        FirestoreExcerciseManager.shared.storeSignedUpUserDetailsOnFirestoreDb { status, message, data in
//
//        }
        super.viewDidLoad()
        
        self.emailTxt.delegate = self
        self.passwordTxt.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func handleSignInActionClick(){
        if(validateForm()){
            authenticateWithFirebaseAuth()
        }
    }
    
    private func validateForm() -> Bool {
        
        let email :String? = emailTxt.text?.removingAllWhitespaces()
        let password:String? = passwordTxt.text?.removingAllWhitespaces()
        
        
        guard let _email = email else {
            showErrorAlert(messageString: "Email Required!")
            return false
        }
        guard !(_email.trimLeadingTralingNewlineWhiteSpaces().isEmpty) else {
            showErrorAlert(messageString: "Enter Valid Email!")
            return false
        }
        guard (_email.isValidEmailAddress()) else {
            showErrorAlert(messageString: "Enter Valid Email!")
            return false
        }
        
        guard let _password = password else {
            showErrorAlert(messageString:"Enter Password!")
            return false
        }
        guard !(_password.isEmpty) else {
            showErrorAlert(messageString:"Enter Password!")
            return false
        }
        
        return true
    }
    
    private func showErrorAlert(messageString:String){
        AlertManager.shared.singleActionMessage(title: "Alert", message: messageString, actionButtonTitle: "Ok", vc: self)
    }
    
    private  func authenticateWithFirebaseAuth(){
        let email :String? = emailTxt.text?.removingAllWhitespaces()
        let password:String? = passwordTxt.text?.removingAllWhitespaces()
        
        RappleActivityIndicatorView.startAnimating()
        Auth.auth().fetchSignInMethods(forEmail: email!){(methods, signInMethodsError) in
            guard let _signInMethods = methods,signInMethodsError == nil else {
                RappleActivityIndicatorView.stopAnimation()
                self.showErrorAlert(messageString: "No User Found with this Email.Please Sign Up!")
                return
            }
            if ( _signInMethods.contains("password")){
                Auth.auth().signIn(withEmail: email!, password: password!){(authResult,signInError) in
                    guard let _authResult = authResult?.user,signInError == nil else {
                        RappleActivityIndicatorView.stopAnimation()
                        self.showErrorAlert(messageString: signInError!.localizedDescription)
                        return
                    }
                    FirestoreUserManager.shared.getUserDetailsStoredOnFirestoreDb(firebaseUser:_authResult) { status, message, data in
                        if (status){
                            var firestoreUser =  data as! FirestoreUser
                            Constants.currentLoggedInFireStoreUser = firestoreUser
                            RappleActivityIndicatorView.stopAnimation()
                            AlertManager.shared.singleActionMessage(title: "Alert", message: "Sign In Successfully!", actionButtonTitle: "Ok", vc: self) { action in
                                //navigate to the app home
                            }
                        }else{
                            RappleActivityIndicatorView.stopAnimation()
                            self.showErrorAlert(messageString: message!)
                        }
                    }
                }
            }else{
                RappleActivityIndicatorView.stopAnimation()
                self.showErrorAlert(messageString: "No User Found with this Email.Please Sign Up!")
                return
            }
        }
    }
    
    @IBAction func signInAction(_ sender: Any) {
        handleSignInActionClick()
    }
    
    @IBAction func navigateTosignupViewAction(_ sender: Any) {
        let vc = ApplicationServiceProvider.shared.viewController(in: .Auth, identifier: "SignUpScreenVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SignInScreenVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
