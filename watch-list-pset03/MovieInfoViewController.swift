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
    @IBOutlet weak var movieYear: UILabel!
    
    var movieId: String?
    var url = URL(string: "")
    var movieInfo: [String : AnyObject] = [:]
    var movieImage = URL(string: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // if movieId received create URL
        if let movieId = movieId {
            url = URL(string: "https://www.omdbapi.com/?i=\(movieId)&plot=full")
        }
   
        
        // getting specific movie information
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("getting json faild more movie info")
            }
            else {
                // if any data retrieved
                if let data = data
                {
                    do {
                        // storing information and json
                        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String : AnyObject]
                        
                        self.movieInfo = json
                        
                        // getting the img
                        let getPoster = URLSession.shared.dataTask(with: URL(string: json["Poster"] as! String)!) { (data, response, error) in
                            
                            // if poster retrieval failed
                            if error != nil {
                                
                                DispatchQueue.main.async {
                                    // display "image not found"
                                    if let filePath = Bundle.main.path(forResource: "noimagefound", ofType: "jpg"), let image = UIImage(contentsOfFile: filePath) {
                                        self.movieImg.image = image
                                    }
                                }
                                
    
                            } else {
                                // if data was retrieved
                                if let data = data {
                                    DispatchQueue.main.async {
                                        self.movieImg.image = UIImage(data: data)
                                    }
                                }
                            }
                        }
                        getPoster.resume()
                        
                        
                        DispatchQueue.main.async {
                            // sending data to view
                            self.MovieName.text = json["Title"] as? String
                            self.movieYear.text = json["Year"] as? String
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


    // if favourite button is presed
    @IBAction func storeFavourite(_ sender: UIButton) {
        
        // getting user data and adding the movie info
        // than putting it back overriding old data
        if var userData = UserDefaults.standard.array(forKey: "1") {
            userData.append(movieInfo)
            UserDefaults.standard.set(userData, forKey: "1")   
        }
    }

    
}
