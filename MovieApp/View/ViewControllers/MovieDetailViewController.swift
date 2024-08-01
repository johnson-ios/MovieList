//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by jaya kumar on 01/08/24.
//

import UIKit

class MovieDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // Properties
    var movieID: String?
    private let viewModel = MovieDetailViewModel()

    @IBOutlet weak var detailsTbleView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        if let movieID = movieID {
            viewModel.fetchMovieDetails(imdbID: movieID)
        }
    }

    private func setupUI() {
        // Set up the UI elements
        view.backgroundColor = .white
        detailsTbleView.dataSource = self
        detailsTbleView.delegate = self
        detailsTbleView.register(UINib(nibName: "MovieDetailsCell", bundle: nil), forCellReuseIdentifier: MovieDetailsCell.identifier)
    }

    private func setupBindings() {
        // Bind ViewModel updates to the UI
        viewModel.onMovieDetailUpdated = { [weak self] in
            self?.configureUI()
        }
    }

    private func configureUI() {
        DispatchQueue.main.async {
            self.detailsTbleView.reloadData()
        }
    }

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // Only one row in the table view for movie details
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 700
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsCell.identifier, for: indexPath) as? MovieDetailsCell else {
            fatalError("Unable to dequeue MovieDetailsCell")
        }

        if let movieDetail = viewModel.movieDetail {
            cell.titleLabel.text = movieDetail.title
            cell.genreLabel.text = "Genre: \(movieDetail.genre)"
            cell.plotLabel.text = movieDetail.plot

            // Load poster image
            if let url = URL(string: movieDetail.poster) {
                ImageService.shared.downloadImage(from: url) { image in
                    DispatchQueue.main.async {
                        cell.posterImageView.image = image
                    }
                }
            }
        }

        return cell
    }
}
