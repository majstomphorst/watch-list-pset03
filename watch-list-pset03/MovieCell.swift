//
//  MovieCell.swift
//  watch-list-pset03
//
//  Created by Maxim Stomphorst on 20/04/2017.
//  Copyright © 2017 M.a.j©. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    // if the value of imageUrl changes to the folowing
    var imageUrl: URL? {
        didSet {
            // start a task on a second thread, go to the imageUrl and extracts image data
            let task = URLSession.shared.dataTask(with: imageUrl!) { (data, response, error) in
                if error != nil {
                    
                    DispatchQueue.main.async {
                        // if getting image failed display "image not found"
                        if let filePath = Bundle.main.path(forResource: "noimagefound", ofType: "jpg"), let image = UIImage(contentsOfFile: filePath) {
                            self.movieImg.image = image
                        }
                    }
                } else {
                    if let data = data {
                       
                        // on the main thread
                        DispatchQueue.main.async {
                            // Assigning image data to Image placeholder
                            self.movieImg.image = UIImage(data: data)
                        }
                    }
                }
            }
            task.resume()
        }
    }

}
