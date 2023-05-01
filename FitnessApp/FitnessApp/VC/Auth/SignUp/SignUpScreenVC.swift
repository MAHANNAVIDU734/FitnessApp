
import UIKit
import FirebaseAuth
import RappleProgressHUD

class SignUpScreenVC: UIViewController {
    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var phoneNumberTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTxt.delegate = self
        self.phoneNumberTxt.delegate = self
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    private func handleSignUpActionClick(){
        if(validateForm()){
            createNewUserOnFirebaseAuth()
        }
    }
    
    private func validateForm() -> Bool {
        var fName:String? = ""
        var email :String? = ""
        var phoneNumber:String? = ""
        var password:String? = ""
        var confirmPassword:String? = ""
        
        
        guard let _fName = fName else {
            showErrorAlert(messageString:"Full Name Required!")
            return false
        }
        guard !(_fName.trimLeadingTralingNewlineWhiteSpaces().isEmpty) else {
            showErrorAlert(messageString: "Enter Valid Full Name!")
            return false
        }
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
        guard let _phoneNumber = phoneNumber else {
            showErrorAlert(messageString:"Phone Number Required!")
            return false
        }
        guard !(_phoneNumber.trimLeadingTralingNewlineWhiteSpaces().isEmpty) else {
            showErrorAlert(messageString:"Enter Valid Phone Number!")
            return false
        }
        guard (_phoneNumber.isValidSLPhoneNumber()) else {
            showErrorAlert(messageString:"Enter Valid SL Phone Number!")
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
        guard let _confirmPassword = confirmPassword else {
            showErrorAlert(messageString:"Enter Confirm Password!")
            return false
        }
        guard !(_confirmPassword.isEmpty) else {
            showErrorAlert(messageString:"Enter Confirm Password!")
            return false
        }
        guard (_confirmPassword == _password) else {
            showErrorAlert(messageString:"Passwords Doesnt Match!")
            return false
        }
        return true
    }
    
    
    private func showErrorAlert(messageString:String){
        AlertManager.shared.singleActionMessage(title: "Alert", message: messageString, actionButtonTitle: "Ok", vc: self)
    }
    
    private func createNewUserOnFirebaseAuth(){
        var email :String? = ""
        var password:String? = ""
        
        RappleActivityIndicatorView.startAnimating()
        Auth.auth().createUser(withEmail: email!, password: password!) { authResult, error in
            guard let user = authResult?.user, error == nil else {
                RappleActivityIndicatorView.stopAnimation()
                self.showErrorAlert(messageString:error!.localizedDescription)
                return
            }
            Constants.currentLoggedInFirebaseAuthUser = user
            let firestoreUser = self.mapFormInputToFirestoreUserObject(firebaseAuthUserId: user.uid)
            FirestoreUserManager.shared.storeSignedUpUserDetailsOnFirestoreDb(firebaseUser: user, firestoreUser: firestoreUser) { status, message, data in
                let _errorMsg = message ?? "Something Went Wrong"
                if(status){
                    AlertManager.shared.singleActionMessage(title: "Alert", message: "Sign up Successful!", actionButtonTitle: "Ok", vc: self) { action in
                        //navigate to the app home
                    }
                }else{
                    RappleActivityIndicatorView.stopAnimation()
                    self.showErrorAlert(messageString: _errorMsg)
                }
            }
        }
    }
    
    private func mapFormInputToFirestoreUserObject(firebaseAuthUserId:String)->FirestoreUser{
        var fName:String? = ""
        var phoneNumber:String? = ""
        
        return FirestoreUser(id: firebaseAuthUserId, fName: fName!, phone: phoneNumber!, avatarUrl: DefaultPlaceHolderLinks.user_avatar.rawValue)
    }
    
    
    @IBAction func signupAction(_ sender: Any) {
        
    }
    
    @IBAction func navigateToSigInViewAction(_ sender: Any) {
        let vc = ApplicationServiceProvider.shared.viewController(in: .Auth, identifier: "SignInScreenVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SignUpScreenVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
