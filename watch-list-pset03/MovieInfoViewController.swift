//
//  MovieInfoViewController.swift
//  watch-list-pset03
//
//  Created by Maxim Stomphorst on 21/04/2017.
//  Copyright © 2017 M.a.j©. All rights reserved.
//

import UIKit

class MovieInfoViewController: UIViewController {
    
    
    @IBOutlet weak var MovieName: UILabel!
    @IBOutlet weak var movieImg: UIImageView!
    
    var movieId: String?
    var url = URL(string: "")
    var movieInfo: [String : AnyObject] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movieId = movieId {
            url = URL(string: "https://www.omdbapi.com/?i=\(movieId)&plot=full")
        }
        
        MovieName.text = "testing"
        
        print("viewDidLoad")
   
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("getting json faild more movie info")
            }
            else {
                if let data = data
                {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String : AnyObject]
                        
                        self.movieInfo = json
                        
                        self.MovieName.text = json["Title"] as? String
                        
                        DispatchQueue.main.async {
                        }
                        
                    }
                    catch {
                        print("erro")
                    }
                }
            }
        }
        task.resume()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
