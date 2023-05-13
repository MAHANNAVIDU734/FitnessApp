
import UIKit

class AddExersiceListTVCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var excerciseTitleLbl: UILabel!
    @IBOutlet weak var setCountLbl: UILabel!
    @IBOutlet weak var repCountLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var setStackView: UIStackView!
    @IBOutlet weak var repStackView: UIStackView!
    @IBOutlet weak var weightStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundImg.layer.cornerRadius = 10
        mainView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {}

    func configCell(scheduleExercise:FirestoreScheduleExercise) {
        let firestoreExercise =  Constants.exerciseDataOnFirestore?.first(where: { firestoreExcercise in
            firestoreExcercise.excerciseId == scheduleExercise.excerciseId
          })
        excerciseTitleLbl.text = firestoreExercise?.exerciseTitle
        
        if  scheduleExercise.weight <= 0  {
            weightStackView.isHidden = true
            return
        }
        setCountLbl.text = "\(scheduleExercise.sets )"
        repCountLbl.text = "\(scheduleExercise.reps )"
        weightLbl.text = "\(scheduleExercise.weight ) Kg"
    }
}
