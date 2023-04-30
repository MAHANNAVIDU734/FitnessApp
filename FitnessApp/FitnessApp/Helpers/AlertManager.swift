
import Foundation


import UIKit

class AlertManager {
    static let shared: AlertManager = {
        let _shared = AlertManager()
        return _shared
    }()

    func singleActionMessage(title: String, message: String, actionButtonTitle: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: actionButtonTitle, style: UIAlertAction.Style.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    
    func multipleActionMessage(title: String, message: String, actionButtonTitles: [String], vc: UIViewController, completion: @escaping AlertActionHandler) {
        let alert = UIAlertController(title: title, message: message , preferredStyle: UIAlertController.Style.alert)
        for action in actionButtonTitles {
            alert.addAction(UIAlertAction(title: action, style: UIAlertAction.Style.default, handler: { (_action) in
                completion(_action.title ?? "")
            }))
        }
        vc.present(alert, animated: true, completion: nil)
    }
    
    func singleActionMessage(title: String, message: String, actionButtonTitle: String, vc: UIViewController,completion: @escaping AlertActionHandler) {
        let alert = UIAlertController(title: title, message: message , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: actionButtonTitle, style: UIAlertAction.Style.default, handler: { (_action) in
            completion(_action.title ?? "")
        }))
        vc.present(alert, animated: true, completion: nil)
    }
}
