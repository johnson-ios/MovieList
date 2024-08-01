//
//  MovieCell.swift
//  MovieApp
//
//  Created by jaya kumar on 01/08/24.
//
import UIKit

protocol MovieCellDelegate: AnyObject {
    func favoriteButtonTapped(on cell: MovieCell)
}

class MovieCell: UITableViewCell {

    static let identifier = "MovieCell"
    weak var delegate: MovieCellDelegate?

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }
    private func updateUI(){
        posterImageView.layer.cornerRadius = 10
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 0
        releaseDateLabel.font = .systemFont(ofSize: 14)
        releaseDateLabel.textColor = .gray
        favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        favoriteButton.tintColor = .systemYellow
        
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    @objc private func favoriteButtonTapped() {
        delegate?.favoriteButtonTapped(on: self)
    }

    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        releaseDateLabel.text = "Release Date: \(movie.year)"
        if let url = URL(string: movie.poster) {
            ImageService.shared.downloadImage(from: url) { [weak self] image in
                DispatchQueue.main.async {
                    self?.posterImageView.image = image
                }
            }
        }
        let favoriteImageName = movie.isFavorite ? "star.fill" : "star"
        favoriteButton.setImage(UIImage(systemName: favoriteImageName), for: .normal)
    }
}
