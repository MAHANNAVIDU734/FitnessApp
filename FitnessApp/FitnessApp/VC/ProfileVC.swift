//
//  ProfileVC.swift
//  FitnessApp
//
//  Created by Shashee on 2023-05-02.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var uploadBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        profileImg.layer.borderWidth = 2
        profileImg.layer.borderColor = UIColor(named: "title")?.cgColor
        
        uploadBtn.layer.cornerRadius = uploadBtn.frame.height / 2
        uploadBtn.layer.borderWidth = 2
        uploadBtn.layer.borderColor = UIColor(named: "title")?.cgColor
    }

    @IBAction func uploadAction(_ sender: Any) {
    }
}
