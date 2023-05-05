
import UIKit
import FirebaseFirestore
import RappleProgressHUD
import FirebaseStorage

class ProfileVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var uploadBtn: UIButton!
    @IBOutlet weak var fullNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var heightTxt: UILabel!
    @IBOutlet weak var weightTxt: UITextField!
    @IBOutlet weak var ageTxt: UITextField!
    @IBOutlet weak var fitnessGoalTxt: UITextField!
    @IBOutlet weak var signoutBtn: UIButton!
    
    private var profileAvatarImageUrl : String = DefaultPlaceHolderLinks.user_avatar.rawValue
    private var imagePickerController = UIImagePickerController()
    private var uploadImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        imagePickerController.delegate = self
        
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        profileImg.layer.borderWidth = 2
        profileImg.layer.borderColor = UIColor(named: "title")?.cgColor
        
        uploadBtn.layer.cornerRadius = uploadBtn.frame.height / 2
        uploadBtn.layer.borderWidth = 2
        uploadBtn.layer.borderColor = UIColor(named: "title")?.cgColor
        
        signoutBtn.layer.cornerRadius = signoutBtn.frame.height / 2
        signoutBtn.layer.borderWidth = 1
        signoutBtn.layer.borderColor = UIColor.white.cgColor
    }
    private func handleSignInActionClick(){
        if(validateForm()){
            updateUserDetailsOnFirestoreDb()
        }
    }
    private func validateForm() -> Bool {
        
        var fName:String? = ""
        var email :String? = ""
        var phoneNumber:String? = ""
        
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
        
        return true
    }
    private func updateUserDetailsOnFirestoreDb(){
        let currentLoggedInFirebaseAuthUser =   Constants.currentLoggedInFirebaseAuthUser
        if let _currentLoggedInFirebaseAuthUser = currentLoggedInFirebaseAuthUser  {
            let updatedFirestoreUserObject = getUpdatedFirestoreUserObject()
            if let _updatedFirestoreUserObject = updatedFirestoreUserObject {
                FirestoreUserManager.shared.storeSignedUpUserDetailsOnFirestoreDb(firebaseUser: _currentLoggedInFirebaseAuthUser, firestoreUser: _updatedFirestoreUserObject) { status, message, data in
                    if(status){
                        AlertManager.shared.singleActionMessage(title: "Alert", message: "Profile Update Successful!", actionButtonTitle: "Ok", vc: self) { action in
                            //navigate back
                        }
                    }else{
                        self.showErrorAlert(messageString: "Something Went Wrong..Please Try Again by Closing the App! ")
                    }
                }
            }else{
                showErrorAlert(messageString: "Something Went Wrong..Please Try Again by Closing the App! ")
            }
            
        } else {
            showErrorAlert(messageString: "Something Went Wrong..Please Try Again by Closing the App! ")
        }
    }
    private func showErrorAlert(messageString:String){
        AlertManager.shared.singleActionMessage(title: "Alert", message: messageString, actionButtonTitle: "Ok", vc: self)
    }
    
    private func getUpdatedFirestoreUserObject()->FirestoreUser?{
        var age:Int? = nil
        var weight :Double? = nil
        var height:Double? = nil
        var fitnessGoal:String? = nil
        
        var updatedLoggedInFireStoreUser =   Constants.currentLoggedInFireStoreUser
        if age != nil{
            updatedLoggedInFireStoreUser?.age = age
        }
        
        if weight != nil{
            updatedLoggedInFireStoreUser?.weight = weight
        }
        
        if height != nil{
            updatedLoggedInFireStoreUser?.height = height
        }
        
        if fitnessGoal != nil{
            updatedLoggedInFireStoreUser?.fitnessGoal = fitnessGoal
        }
        
        updatedLoggedInFireStoreUser?.avatarUrl = profileAvatarImageUrl
        
        return updatedLoggedInFireStoreUser
        
    }
    private  func showImageSourcePickerAlert() {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            self.openGallary()
        }))
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private  func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePickerController.sourceType = UIImagePickerController.SourceType.camera
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    private  func openGallary() {
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func uploadImageAndGetUrl(){
        self.uploadImageToFirebaseStorage(image: uploadImage!){ url in
            self.profileAvatarImageUrl = url?.absoluteString ?? DefaultPlaceHolderLinks.user_avatar.rawValue
        }
    }
    private func  uploadImageToFirebaseStorage(image :UIImage, completion: @escaping ((_ url: URL?) -> ())) {
        let imageFullPathString = CommonHelpers.generateFilePathForFirebaseStorage(fileCategory: FirebaseStorageFileCategories.users)
        
        let storageRef = Storage.storage().reference().child(imageFullPathString)
        let imgData = image.pngData()
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        RappleActivityIndicatorView.startAnimating()
        storageRef.putData(imgData!, metadata: metaData) { (metadata, error) in
            if error == nil{
                storageRef.downloadURL(completion: { (url, error) in
                    RappleActivityIndicatorView.stopAnimating()
                    completion(url)
                })
            }else{
                RappleActivityIndicatorView.stopAnimating()
                self.showErrorAlert(messageString: error?.localizedDescription ?? "Failed to Upload Image!")
                print(error?.localizedDescription)
                completion(nil)
            }
        }
        
    }
    @IBAction func uploadAction(_ sender: Any) {
        showImageSourcePickerAlert()
    }
    @IBAction func submitAction(_ sender: Any) {
        
    }
    @IBAction func signoutAction(_ sender: Any) {
        
    }
}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let photo = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        self.uploadImage = photo
        self.profileImg.image = photo
        self.dismiss(animated: true, completion: nil)
        if (photo != nil ){
            uploadImageAndGetUrl()
        }        
    }
}
