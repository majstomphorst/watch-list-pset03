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
        
        
        
        if let movieId = movieId {
            url = URL(string: "https://www.omdbapi.com/?i=\(movieId)&plot=full")
        }
   
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
                        
                        // getting the img
                        let getPoster = URLSession.shared.dataTask(with: URL(string: json["Poster"] as! String)!) { (data, response, error) in
                            if error != nil {
                                print("poster error")
                            } else {
                                if let data = data {
                                    let image = UIImage(data: data)
                                    
                                    DispatchQueue.main.async {
                                        self.movieImg.image = image
                                    }
                                }
                            }
                        }
                        getPoster.resume()
                        
                        
                        DispatchQueue.main.async {
                            // yay f*ck up the naming again.....
                            self.MovieName.text = json["Title"] as? String
                            self.movieYear.text = json["Year"] as? String
                        }
                        
                        
                    }
                    catch {
                        print("erro")
                    }
                }
            }
        }
        task.resume()
        
        
        // let LoadImg = URLSession.shared.dataTask(with: URL)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func storeFavourite(_ sender: UIButton) {
        
        if var userData = UserDefaults.standard.array(forKey: "1") {
            userData.append(movieInfo)
            UserDefaults.standard.set(userData, forKey: "1")   
        }
        // get user data and append
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
