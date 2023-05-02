import UIKit
import Kingfisher

class ExerciseTVCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var cantainerView: UIView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var animationImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell()
    }
    func setUpCell() {
        cantainerView.layer.cornerRadius = 15
        cantainerView.layer.borderWidth = 0.5
        cantainerView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {}
    
    func config(firestoreExercise: FirestoreExcercise?) {
        guard let _firestoremodel = firestoreExercise else { return }
        titleLbl.text = _firestoremodel.exerciseTitle
        descriptionLbl.text = firestoreExercise?.exerciseDescription
        animationImg.kf.setImage(with: URL(string: firestoreExercise?.exerciseGIFs.first ?? ""))
    }
    
}
