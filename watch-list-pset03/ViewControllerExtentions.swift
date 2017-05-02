//
//  ViewControllerExtentions.swift
//  watch-list-pset03
//
//  Created by Maxim Stomphorst on 02/05/2017.
//  Copyright © 2017 M.a.j©. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    // allert function it show a alert only
    func showAlert(title: String, message: String) {
        
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func askUserAlert (title: String, message: String, completion: @escaping ((Bool) -> Void)) {
        
        // Initialize Alert Controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Initialize Actions
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { (action) in
            completion(true)
        }
        
        // if no is selected to nothing
        let noAction = UIAlertAction(title: "No", style: .default) { (action) in
            completion(false)
        }
        
        // Add Actions
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        // Present Alert Controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    
        
    
}
