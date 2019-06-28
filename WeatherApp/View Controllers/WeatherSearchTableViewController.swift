//
//  WeatherSearchTableViewController.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/25/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import UIKit

class WeatherSearchTableViewController: UITableViewController {
    
    enum TableViewSection: Int {
        case search
        case searchHistory
        case total
    }
    
    // MARK: - Property

    weak var coordinator: WeatherSearchCoordinator?
    
    var searchController: UISearchController?
    var viewModel: WeatherSearchViewModel?
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Weather"
        navigationController?.navigationBar.prefersLargeTitles = true

        setupSearchController()
        setupTableView()
    }
    
    // MARK: - Set up
    
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search City Name, Zip Code"
        searchController.searchBar.showsCancelButton = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self

        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        
        definesPresentationContext = true
    }
    
    private func setupTableView() {
        tableView.keyboardDismissMode = .onDrag
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Table view
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return TableViewSection.total.rawValue
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tableViewSection = TableViewSection(rawValue: section) else {
            preconditionFailure("Error: Wrong table view section defined")
        }
        
        switch tableViewSection {
        case .search:
            if let viewModel = viewModel {
                return viewModel.hasSearchKeywords ? 2 : 0
            }
            return 0
        case .searchHistory:
            return 0
        case .total:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewSection = TableViewSection(rawValue: indexPath.section) else {
            preconditionFailure("Error: Wrong table view section defined")
        }
        
        guard let viewModel = viewModel else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherSearchCell", for: indexPath)
        
        switch tableViewSection {
        case .search:
            if indexPath.row == 0 {
                cell.textLabel?.text = "Search for City \"\(viewModel.searchKeywords)\""
            } else {
                cell.textLabel?.text = "Search for Zip Code \"\(viewModel.searchKeywords)\""
            }
        case .searchHistory:
            break
        case .total:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let tableViewSection = TableViewSection(rawValue: section) else {
            preconditionFailure("Error: Wrong table view section defined")
        }
        
        if tableViewSection == .searchHistory {
            return "Recent Searches"
        }

        return nil
    }
    
    func reloadTableViewWhenSearchTextChange(searchText: String) {
        if searchText.count <= 1 {
            tableView.reloadSections([0, 1], with: .automatic)
        } else {
            tableView.reloadData()
        }
    }
}

extension WeatherSearchTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.searchKeywords.removeAll()
        reloadTableViewWhenSearchTextChange(searchText: "")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.searchKeywords = searchText
        reloadTableViewWhenSearchTextChange(searchText: searchText)
    }
}

extension WeatherSearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
