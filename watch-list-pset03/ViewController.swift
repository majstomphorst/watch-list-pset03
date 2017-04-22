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
    
    let url = URL(string: "https://www.omdbapi.com/?s=avatar")
    var items: [[String : AnyObject]] = []
    var send = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("getting json faild error")
            }
            else {
                if let data = data
                {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String : AnyObject]
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you selectd row#\(indexPath)")
        
        send = items[indexPath.row]["Title"] as! String
        print(type(of: send))
        
        // segue to the next controller
        self.performSegue(withIdentifier: "movieInfoSegue", sender: "")
    
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieInfoVC = segue.destination as? MovieInfoViewController {
            movieInfoVC.test = send
        }
    }
    
    
    
    //MARK: actions
    // search bar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var search = self.search.text
        print(search!)
        
        search = search?.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        
        let url = URL(string: "https://www.omdbapi.com/?s=\(search!)")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("getting json faild error")
            }
            else {
                if let data = data
                {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String : AnyObject]
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

