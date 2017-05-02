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
    
}
