//
//  SearchMoviesViewController.swift
//  MoviesApp
//
//  Created by Guillermo Gutierrez on 7/29/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import UIKit
import MovieDBRepository
import MovieDataBase

class SearchMoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SearchMoviesViewDelegate {

    @IBOutlet weak var moviesTableView: UITableView!
    
    var moviesList = [Movie]()
    
    var navController: UINavigationController!
    
    lazy var presenter = SearchMoviesPresenter(repository: DependencyInjector.dependencies.resolveRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("SearchMoviesViewController initialized")
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        presenter.setViewDelegate(viewDelegate: self)
    }
    
    // MARK: table view methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableViewCell
        cell.titleLabel.text = moviesList[indexPath.row].title
        NSLog("title %@", moviesList[indexPath.row].title ?? "Defautl value")
        cell.searchCellImageView.image = nil
        
        if let image = moviesList[indexPath.row].posterImage {
            cell.searchCellImageView.image = UIImage(data: image)
            cell.searchCellImageView.layer.cornerRadius = cell.searchCellImageView.frame.size.width / 2;
            
            cell.searchCellImageView.layer.masksToBounds = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        controller.movie = moviesList[indexPath.row]

        self.navController?.pushViewController(controller, animated: true)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let cell = sender as? UITableViewCell, let indexPath = moviesTableView.indexPath(for: cell) {
//            let controller = (segue.destination as! UINavigationController).topViewController as! MovieDetailsViewController
//            controller.movie = moviesList[indexPath.row]
//        }
//    }
    
    
    // MARK: view delegate methods
    func displayMovies(movies: [Movie]) {
        self.moviesList = movies
        self.moviesTableView.reloadData()
    }
    
    func showError(message: String) {
        // todo
    }
}

// MARK: - UISearchResultsUpdating Delegate methods
extension SearchMoviesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        // fetch movies whenever the search bar becomes the first responder
        if !searchController.searchBar.text!.isEmpty {
            presenter.fetchMovies(byName: searchController.searchBar.text)
        } else {
             presenter.fetchMovies()
        }
    }
}
