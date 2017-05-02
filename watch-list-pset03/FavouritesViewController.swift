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
    
    // give tableview the amount of tabels
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // get user data from usderdefault and count the number of items
        if let userData = UserDefaults.standard.array(forKey: "1") {
            return userData.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // creating cell property
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell" , for: indexPath) as! FavouritesTableViewCell
        
        // getting user data to fill cell
        if let userData = UserDefaults.standard.array(forKey: "1") {
            
            // casting user data to a dict
            let favorites = userData[indexPath.row] as! [String : AnyObject]
            
            // fillng cell with data
            cell.movieTitle.text = favorites["Title"] as? String
            cell.movieYear.text = favorites["Year"] as? String
            
            
            // getting the img
            let getPoster = URLSession.shared.dataTask(with: URL(string: favorites["Poster"] as! String)!) { (data, response, error) in
                
                // if image failed
                if error != nil {
                    DispatchQueue.main.async {
                        // display "image not found"
                        if let filePath = Bundle.main.path(forResource: "noimagefound", ofType: "jpg"), let image = UIImage(contentsOfFile: filePath) {
                            cell.movieImage.image = image
                        }
                    }
                // if image succeeds give image to movieImage
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
        // return the created cell
        return cell
    }
    
    // if the movie is selected as user to delete the movie
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // get user data
        if var userData = UserDefaults.standard.array(forKey: "1") {

            // create placeholder
            var data: [String : AnyObject]
            
            // get cast data
            data = userData[indexPath.row] as! [String : AnyObject]
            
            // Initialize Alert Controller
            let alertController = UIAlertController(title: "are you sure you want to delete", message: "Movie title: \(data["Title"]! as! String)", preferredStyle: .alert)
        
            // Initialize Actions
            // if yes is selected delete the item and reload tabeview
            let yesAction = UIAlertAction(title: "Yes", style: .destructive) { (action) in
            
                userData.remove(at: indexPath.row)
                UserDefaults.standard.set(userData, forKey: "1")
                
                tableView.reloadData()
            
            }
            
            // if no is selected to nothing
            let noAction = UIAlertAction(title: "No", style: .default)
        
            // Add Actions
            alertController.addAction(yesAction)
            alertController.addAction(noAction)
        
            // Present Alert Controller
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}
