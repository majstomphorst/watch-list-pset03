//
//  ViewController.swift
//  watch-list-pset03
//
//  Created by Maxim Stomphorst on 18/04/2017.
//  Copyright © 2017 M.a.j©. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITabBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let mtitle = ["movie01", "movie02", "movie03"]
    
    let desc = [
        "movie01": "MOVIE01",
        "movie02": "MOVIE02",
        "movie03": "MOVIE03"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mtitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        as! MovieCell
        
        cell.movieTitle.text = mtitle[indexPath.row]
        
        if let tmp = desc[mtitle[indexPath.row]] {
            cell.movieDescription.text = tmp
        }
        
        return cell
    }

}

