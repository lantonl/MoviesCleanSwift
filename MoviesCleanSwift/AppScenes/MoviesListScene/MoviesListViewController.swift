//
//  MoviesListViewController.swift
//  MoviesCleanSwift
//
//  Created by Anton Gutkin on 18.01.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MoviesListDisplayLogic: AnyObject {
    func displayLoadingindicator()
    func hideLoadingindicator()
    func display(error: NetworkResponseError)
    func display(message: MoviesList.UI.Message)
    func displayMovies(viewModel: MoviesList.UI.ViewModel)
}

class MoviesListViewController: BaseViewController {
    private struct Constants {
        static let searchBarPlaceholderText = "Search Films"
        static let backgroundColor = UIColor.white
    }
    
    var interactor: MoviesListBusinessLogic?
    var router: (NSObjectProtocol & MoviesListRoutingLogic & MoviesListDataPassing)?
    
    @IBOutlet private var tableView: UITableView!
    
    private let searchController = UISearchController(searchResultsController: nil)

    private var cellConfigurations = [MoviesList.UI.CellConfiguration]()
    
    private var titleForSearching = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
        setupSearchController()
        interactor?.initialRequest()
        
        view.backgroundColor = Constants.backgroundColor
        tableView.backgroundColor = Constants.backgroundColor
    }
    
    func selectedRow() -> Int? {
        return tableView.indexPathForSelectedRow?.row
    }
    
    private func requestFirstPageForMovies(with title: String) {
        titleForSearching = title
        let request = MoviesList.Movies.Request(title: title)
        interactor?.getFirstBatchOfMovies(for: request)
        tableView.setContentOffset(.zero, animated: true)
    }
    
    private func requestNextPageForMovies() {
        guard !titleForSearching.isEmpty else {
            return
        }
        
        let request = MoviesList.Movies.Request(title: titleForSearching)
        interactor?.getNextBatchOfMovies(for: request)
    }

    private func setup() {
        let viewController = self
        let interactor = MoviesListInteractor()
        let presenter = MoviesListPresenter()
        let router = MoviesListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: String(describing: MovieTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MovieTableViewCell.self))
        tableView.register(UINib(nibName: String(describing: LoadingTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LoadingTableViewCell.self))
    }
    
    private func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.searchBarPlaceholderText
        searchController.searchBar.tintColor = .black
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension MoviesListViewController: MoviesListDisplayLogic {
    func display(message: MoviesList.UI.Message) {
        show(message: message.description, title: message.title)
    }
    
    func displayMovies(viewModel: MoviesList.UI.ViewModel) {
        cellConfigurations = viewModel.cellConfigurations
        tableView.reloadData()
    }
    
    func displayLoadingindicator() {
        showLoadingController(aboveNavBar: true)
    }
    
    func hideLoadingindicator() {
        hideLoadingController()
    }
    
    func display(error: NetworkResponseError) {
        show(error: error)
    }
}

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellConfigurations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < cellConfigurations.count else {
            return UITableViewCell()
        }
        
        var cell = UITableViewCell()
        
        let cellType = cellConfigurations[indexPath.row].cellType
        
        switch cellType {
        case .movie:
            guard let movieCell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieTableViewCell.self), for: indexPath) as? ConfigurableTableViewCell else {
                return cell
            }
            
            movieCell.congigureCell(with: cellConfigurations[indexPath.row].configuration)
            
            cell = movieCell
        case .loading:
            guard let loadingCell = tableView.dequeueReusableCell(withIdentifier: String(describing: LoadingTableViewCell.self), for: indexPath) as? ConfigurableTableViewCell else {
                return cell
            }
            
            loadingCell.congigureCell(with: cellConfigurations[indexPath.row].configuration)
            
            cell = loadingCell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard cell is LoadingTableViewCell else {
            return
        }
        
        requestNextPageForMovies()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routToMovieDetails()
    }
}

extension MoviesListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let titleForSearching = searchBar.text else {
            return
        }
        
        requestFirstPageForMovies(with: titleForSearching)
    }
}
