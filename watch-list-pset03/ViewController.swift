//
//  ViewController.swift
//  watch-list-pset03
//
//  Created by Maxim Stomphorst on 18/04/2017.
//  Copyright © 2017 M.a.j©. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var search: UISearchBar!
    
    // creating variabels to store information
    var items: [[String : AnyObject]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // checking for user data if there is data do nothing if not create it
        if UserDefaults.standard.array(forKey: "1") == nil {
            // create empty user data
            let userData = [[String : AnyObject]]()
            // storing empty user data
            UserDefaults.standard.set(userData, forKey: "1")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // returning a number of items to be displayed
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // selecting a cell to be populated
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        as! MovieCell

        // Populating cell (tableview)
        cell.imageUrl = URL(string: items[indexPath.row]["Poster"] as! String)
        cell.movieTitle.text = items[indexPath.row]["Title"] as? String
        cell.movieDescription.text = items[indexPath.row]["Year"] as? String
        
        // returning the cell to be Display
        return cell
    }

    // if a movie is selected (cell) store that information end send it to the MovieInfoVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieInfoSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destVC = segue.destination as! MovieInfoViewController
                    destVC.movieId = (items[indexPath.row]["imdbID"] as! String)
            }
        }
    }
    
    //MARK: actions
    
    // search bar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // getting user search term
        var search = self.search.text
        
        // sanitising user input (serch term)
        search = search?.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        
        // creating the url where the information is tobe extracted
        let url = URL(string: "https://www.omdbapi.com/?s=\(search!)")
        
        // go to the url and get the data no a second thread (smooth UserExperince)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                self.showAlert(title: "Getting json failed", message: "Story, let's tried it again")
                
            } else {
                // if data exists
                if let data = data
                {
                    do {
                        // interpreting data is json format
                        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String : AnyObject]
                        
                        // if json interpretation succeeded
                        if let items = json["Search"] as? [[String : AnyObject]] {
                            self.items = items
                        } else {
                            // if json interputation fialed
                            DispatchQueue.main.async {
                                self.showAlert(title: "I couldn't find that movie", message: "Server reports: \(json["Error"] as! String)")
                            }
                        }
                    
                        // update the table view on the main thread
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch {
                        self.showAlert(title: "Something crashed!", message: "let's tried it again")
                    }
                }
            }
        }
        task.resume()
    }
  
    
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


