//
//  SearchViewController.swift
//  NetflexClone
//
//  Created by 김희진 on 2022/04/03.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {

    private var titles: [Title] = [Title]()
    
    private let discoverTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultViewController())
        controller.searchBar.placeholder = "Search for a movie!"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(discoverTable)
        discoverTable.delegate = self
        discoverTable.dataSource = self

        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .white
        
        fetchDiscoverMovies()
        searchController.searchResultsUpdater = self
    }
    
    private func fetchDiscoverMovies(){
        APICaller.shated.getDiscoverMovies{ [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                
                DispatchQueue.main.async {
                    self?.discoverTable.reloadData()
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }
}


extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        let title = titles[indexPath.row]
        let model = TitleViewModel(titleName: title.original_name ?? title.original_title ?? "unknown", posterURL: title.poster_path ?? "")
        cell.configure(with: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}


extension SearchViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text , !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3, let resultsController = searchController.searchResultsController as? SearchResultViewController else {
            return
        }
        
        APICaller.shated.search(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    resultsController.title2 = titles
                    resultsController.searchResultsCollectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
