

import UIKit

class SchedulTVCell: UITableViewCell {
    
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundImg.layer.cornerRadius = 10
        mainView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {}

    func configCell() {
        
    }
}
