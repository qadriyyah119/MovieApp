//
//  Alertable.swift
//  MovieApp
//
//  Created by Qadriyyah Thomas on 9/7/21.
//

import UIKit

protocol Alertable: UIViewController {
    func displayAlertViewController(withTitle title: String, message: String, alertActionTitle: String)
}

extension Alertable {
    func displayAlertViewController(withTitle title: String, message: String, alertActionTitle: String = "OK") {
        let controller: UIAlertController = UIAlertController(title: title,
                                                              message: message,
                                                              preferredStyle: .alert)
        let ok = UIAlertAction(title: alertActionTitle,
                               style: .default, handler: nil)
        controller.addAction(ok)
        
        if Thread.isMainThread {
            self.present(controller, animated: true, completion: nil)
        } else {
            DispatchQueue.main.async {
                self.present(controller, animated: true, completion: nil)
            }
        }
    }
}
