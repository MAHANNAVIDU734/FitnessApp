//
//  WorkoutTVCell.swift
//  FitnessApp
//
//  Created by Shashee on 2023-05-01.
//

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

}
