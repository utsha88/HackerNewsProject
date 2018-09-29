//
//  ViewControllerExtension.swift
//  Omnify
//
//  Created by Utsha Guha on 9/27/18.
//  Copyright © 2018 Utsha Guha. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension UIViewController{
    func showAlert(heading:String, message:String, buttonTitle:String) {
        let alert = UIAlertController(title: heading, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
