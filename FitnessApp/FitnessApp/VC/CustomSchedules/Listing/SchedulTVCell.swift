

import UIKit

class SchedulTVCell: UITableViewCell {
    
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var scheduleTitleLbl: UILabel!
    @IBOutlet weak var TotalDurationLbl: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundImg.layer.cornerRadius = 10
        mainView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {}

    func configCell(firestoreSchedule:FirestoreSchedule) {
        scheduleTitleLbl.text = firestoreSchedule.scheduleTitle
        TotalDurationLbl.text = firestoreSchedule.totalTime.description
    }
    
    @IBAction func playAction(_ sender: Any) {
        
    }
    
}
