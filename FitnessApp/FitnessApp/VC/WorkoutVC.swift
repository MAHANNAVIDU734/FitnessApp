//
//  WorkoutVC.swift
//  FitnessApp
//
//  Created by Shashee on 2023-05-01.
//

import UIKit

class WorkoutVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension WorkoutVC: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutTVCell" , for: indexPath)
        if let _cell = cell as? WorkoutTVCell {
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ApplicationServiceProvider.shared.viewController(in: .Auth, identifier: "WorkoutTVCell")
        if let _vc = vc as? WorkoutTVCell {
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

