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
    @IBOutlet weak var movieImdbRating: UILabel!
    @IBOutlet weak var movieTomatoRating: UILabel!
    @IBOutlet weak var moviePlot: UITextView!
    
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
                self.showAlert(title: "Getting json failed", message: "Story, let's tried it again")
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
                            self.moviePlot.text = json["Plot"] as? String
                            
                            let ratings = self.movieInfo["Ratings"] as? [[String : AnyObject]]
                            
                            self.movieImdbRating.text = "IMDB: \(ratings![0]["Value"]! as! String)"
                            self.movieTomatoRating.text = "Tomato: \(ratings![1]["Value"]! as! String)"
                            
//                            do {
//                                self.movieImdbRating.text = "IMDB: \(ratings![0]["Value"]! as! String)"
//                                self.movieTomatoRating.text = "Tomato: \(ratings![1]["Value"]! as! String)"
//                            } catch {
//                                self.movieImdbRating.text = "unavailable"
//                                self.movieTomatoRating.text = "unavailable"
//                            }
                            
                            
                        }
                    } catch {
                        // if error tell user
                        self.showAlert(title: "Something is wrong", message: "sorry")
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
