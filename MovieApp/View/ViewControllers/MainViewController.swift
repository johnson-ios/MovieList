//
//  ViewController.swift
//  MovieApp
//
//  Created by jaya kumar on 01/08/24.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, MovieCellDelegate {

    @IBOutlet weak var lblMovie: UILabel!
    @IBOutlet weak var searchTxt: UITextField!
    @IBOutlet weak var listTbleView: UITableView!

    private let viewModel = MovieListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.onMoviesUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.listTbleView.reloadData()
            }
        }
        viewModel.fetchMovies(query: "Marvel") // Example query
    }

    private func setupUI() {
        searchTxt.layer.cornerRadius = 8.0
        searchTxt.layer.masksToBounds = true
        searchTxt.layer.borderWidth = 1.0
        searchTxt.layer.borderColor = UIColor.gray.cgColor
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: searchTxt.frame.height))
        searchTxt.leftView = paddingView
        searchTxt.leftViewMode = .always
        view.backgroundColor = .white
        lblMovie.text = "Movies"
        searchTxt.delegate = self
        listTbleView.dataSource = self
        listTbleView.delegate = self
        listTbleView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: MovieCell.identifier)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterMovies(by: searchText)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMovies()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        let movie = viewModel.movie(at: indexPath.row)
        cell.configure(with: movie)
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.movie(at: indexPath.row)
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        detailVC.movieID = movie.imdbID
        navigationController?.pushViewController(detailVC, animated: true)
    }

    func favoriteButtonTapped(on cell: MovieCell) {
        if let indexPath = listTbleView.indexPath(for: cell) {
            let movie = viewModel.movie(at: indexPath.row)
            viewModel.toggleFavorite(for: movie)
        }
    }
}
