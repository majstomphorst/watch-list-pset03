//
//  MovieCell.swift
//  watch-list-pset03
//
//  Created by Maxim Stomphorst on 20/04/2017.
//  Copyright © 2017 M.a.j©. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    var imageUrl: URL? {
        didSet {
            let task = URLSession.shared.dataTask(with: imageUrl!) { (data, response, error) in
                if error != nil {
                    print("getting img faild error")
                }
                else {
                    if let data = data {
                        let image = UIImage(data: data)
                        
                        DispatchQueue.main.async {
                            self.movieImg.image = image
                        }
                    }
                }
            }
            task.resume()
        }
    }

    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
