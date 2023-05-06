
import UIKit

class MyExcercieTVCell: UITableViewCell {

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

    func configCell(sat: Double?, rep: Double?, weight: Double?) {
        guard let _sat = sat else {
            setStackView.isHidden = true
            return
        }
        guard let _rep = rep else {
            repStackView.isHidden = true
            return
        }
        guard let _weight = weight else {
            weightStackView.isHidden = true
            return
        }
        setCountLbl.text = "\(sat ?? 0.0)"
        repCountLbl.text = "\(rep ?? 0.0)"
        weightLbl.text = "\(weight ?? 0.0)"
    }
}
