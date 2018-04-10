//
//  MovieTableViewCell.swift
//  MoviesLib
//
//  Created by Eric Brito on 27/03/17.
//  Copyright © 2017 EricBrito. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSummary: UILabel!
    @IBOutlet weak var lbRating: UILabel!
    
    var movie: Movie! {
        didSet {
            ivPoster.image = movie.poster
            lbTitle.text = movie.title
            lbRating.text = "\(movie.rating)"
            lbSummary.text = movie.summary
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
