import UIKit

class WorkoutTVCell: UITableViewCell {
    
    @IBOutlet weak var cantainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell()
    }
    func setUpCell() {
        cantainerView.layer.cornerRadius = 15
        cantainerView.layer.borderWidth = 0.5
        cantainerView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func config(firestoreExercise: FirestoreExcercise) {
        print("Document Exercise******")
        let title =  firestoreExercise.exerciseTitle
        print(title)
        print("Document Title******")
        let description =  firestoreExercise.exerciseDescription
        let exerciseGif =  firestoreExercise.exerciseGIFs.first
    }
    
}
