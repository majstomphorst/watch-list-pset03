//
//  FavouritesViewController.swift
//  watch-list-pset03
//
//  Created by Maxim Stomphorst on 24/04/2017.
//  Copyright © 2017 M.a.j©. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var favTableView: UITableView!
    
    // var userData: [[String : AnyObject]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let userData = UserDefaults.standard.array(forKey: "1") {
//            print("User data:")
//            print(userData)
//            print(userData.count)
//        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let userData = UserDefaults.standard.array(forKey: "1") {
            print("User data:")
            print(userData.count)
            
            return userData.count
        }
        print("failed row")
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell" , for: indexPath) as! FavouritesTableViewCell
        
        if let userData = UserDefaults.standard.array(forKey: "1") {
            print("User data:")
            print(userData.count)
            let dict = userData[indexPath.row] as! [String : AnyObject]
            print(dict["Title"]!)
            
            cell.movieTitle.text = dict["Title"] as? String
            cell.movieYear.text = dict["Year"] as? String
        }
    
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
