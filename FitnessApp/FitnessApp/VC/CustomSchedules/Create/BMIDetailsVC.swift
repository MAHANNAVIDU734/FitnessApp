//
//  BMIDetailsVC.swift
//  FitnessApp
//
//  Created by Shashee on 2023-05-12.
//

import UIKit

class BMIDetailsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var BmiValueLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension BMIDetailsVC: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return excerciseList.count
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutTVCell" , for: indexPath)
        if let _cell = cell as? ExerciseTVCell {
//            _cell.config(firestoreExercise:excerciseList[indexPath.row] )
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        navigateToAddExerciseDetails(selectedFirestoreExercise: excerciseList[indexPath.row] )
    }
}
