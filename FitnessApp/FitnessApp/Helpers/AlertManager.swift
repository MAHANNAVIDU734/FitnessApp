
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
    
    
    func multipleActionMessage(title: String, message: String, possitiveActionButtonTitle: String,completionPossitiveAction: @escaping AlertActionHandler ,vc: UIViewController, negativeActionButtonTitle: String,completionNegativeAction: @escaping AlertActionHandler  ) {
        let alert = UIAlertController(title: title, message: message , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: possitiveActionButtonTitle, style: UIAlertAction.Style.default, handler: { (_action) in
            completionPossitiveAction(_action.title ?? "")
        }))
        alert.addAction(UIAlertAction(title: negativeActionButtonTitle, style: UIAlertAction.Style.default, handler: { (_action) in
            completionNegativeAction(_action.title ?? "")
        }))
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
