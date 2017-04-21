//
//  ViewController.swift
//  watch-list-pset03
//
//  Created by Maxim Stomphorst on 18/04/2017.
//  Copyright © 2017 M.a.j©. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITabBarDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var search: UISearchBar!
    
    let url = URL(string: "https://www.omdbapi.com/?s=rogue")
    
    var items: [[String : AnyObject]] = []
    
//    let mtitle = ["movie01", "movie02", "movie03"]
//    
//    let desc = [
//        "movie01": "MOVIE01",
//        "movie02": "MOVIE02",
//        "movie03": "MOVIE03"
//    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("getting json faild error")
            }
            else {
                if let content = data
                {
                    do {
                        let json = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String : AnyObject]
                        let items = json["Search"] as! [[String : AnyObject]]
                        
                        self.items = items
                        
                        // process json -> mtitle
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                    catch {
                        print("error")
                    }
                }
            }
        }
        task.resume()
 
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    // search bar 
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let keywords = search.text
        print(keywords!)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        as! MovieCell
        
        cell.imageUrl = URL(string: items[indexPath.row]["Poster"] as! String)
        cell.movieTitle.text = items[indexPath.row]["Title"] as? String
        cell.movieDescription.text = items[indexPath.row]["Year"] as? String
        
        
        return cell
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

