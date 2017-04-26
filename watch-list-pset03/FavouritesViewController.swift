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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let userData = UserDefaults.standard.array(forKey: "1") {
            return userData.count
        }
        print("failed row")
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell" , for: indexPath) as! FavouritesTableViewCell
        
        if let userData = UserDefaults.standard.array(forKey: "1") {
            
            let dict = userData[indexPath.row] as! [String : AnyObject]
            
            cell.movieTitle.text = dict["Title"] as? String
            cell.movieYear.text = dict["Year"] as? String
            
            
            // getting the img
            let getPoster = URLSession.shared.dataTask(with: URL(string: dict["Poster"] as! String)!) { (data, response, error) in
                if error != nil {
                    print("poster error")
                } else {
                    if let data = data {
                        let image = UIImage(data: data)
                        
                        DispatchQueue.main.async {
                            cell.movieImage.image = image
                        }
                    }
                }
            }
            getPoster.resume()
        }
    
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if var userData = UserDefaults.standard.array(forKey: "1") {
        
            userData.remove(at: indexPath.row)
            
            UserDefaults.standard.set(userData, forKey: "1")
            
            tableView.reloadData()
        }
        print(indexPath.row)
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
