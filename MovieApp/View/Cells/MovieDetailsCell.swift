//
//  MovieDetailsCell.swift
//  MovieApp
//
//  Created by jaya kumar on 01/08/24.
//

import UIKit

class MovieDetailsCell: UITableViewCell {
    @IBOutlet weak var viewOver: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    static let identifier = "MovieDetailsCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    private func setupUI() {
           // Set up the UI elements
           posterImageView.layer.cornerRadius = 10
           posterImageView.contentMode = .scaleAspectFill
           posterImageView.clipsToBounds = true
           genreLabel.textColor = .gray
           
       }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
