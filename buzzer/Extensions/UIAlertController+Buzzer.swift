//
//  UIAlertController+Buzzer.swift
//  buzzer
//
//  Created by Alan Scarpa on 5/2/17.
//  Copyright © 2017 The Scarpa Group. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func createSimpleAlert(withTitle title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(action)
        return alertController
    }
}
