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

        setupNavigationController()
        setupSearchController()
        setupTableView()
    }
    
    // MARK: - Set up
    
    private func setupNavigationController() {
        title = "Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
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
    
    // MARK: - Action
    
    @IBAction func didClickSearchCurrentLocation(_ sender: Any) {
        
    }
    
    // MARK: - Table view datasource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return TableViewSection.total.rawValue
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tableViewSection = TableViewSection(rawValue: section) else {
            preconditionFailure("Error: Wrong table view section defined")
        }
        
        guard let viewModel = viewModel else {
            return 0
        }
        
        switch tableViewSection {
        case .search:
            return viewModel.hasSearchKeywords ? 2 : 0
        case .searchHistory:
            return viewModel.hasSearchHistory ? viewModel.searchHistory.count : 0
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
        cell.selectionStyle = .default
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.textColor = .black
        
        switch tableViewSection {
        case .search:
            if indexPath.row == 0 {
                cell.textLabel?.text = "Search by City \"\(viewModel.searchKeywords)\""
            } else {
                cell.textLabel?.text = "Search by Zip Code \"\(viewModel.searchKeywords)\""
            }
        case .searchHistory:
            if !viewModel.hasSearchHistory {
                cell.textLabel?.text = "Empty"
                cell.selectionStyle = .none
                cell.accessoryType = .none
                cell.textLabel?.textColor = .lightGray
            }
        case .total:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let tableViewSection = TableViewSection(rawValue: section) else {
            preconditionFailure("Error: Wrong table view section defined")
        }
        
        let hasSearchHistory = viewModel?.hasSearchHistory ?? false
        
        if tableViewSection == .searchHistory && hasSearchHistory {
            return "Recent Searches"
        }

        return nil
    }
    
    // MARK: - Table View Delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        dismissKeyboard()
        
        guard let tableViewSection = TableViewSection(rawValue: indexPath.section) else {
            return
        }
        
        guard let viewModel = viewModel else {
            return
        }
        
        switch tableViewSection {
        case .search:
            if indexPath.row == 0 {
                let weatherSearchInfo = WeatherSearch(searchType: .cityName(name: viewModel.searchKeywords))
                coordinator?.showWeatherDetail(with: weatherSearchInfo)
            } else {
                let weatherSearchInfo = WeatherSearch(searchType: .zipCode(code: viewModel.searchKeywords))
                coordinator?.showWeatherDetail(with: weatherSearchInfo)
            }
        case .searchHistory:
//            coordinator?.showWeatherDetail(keywords: "")
            break
        case .total:
            break
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Helper

    func reloadTableViewWhenSearchTextChange(searchText: String) {
        if searchText.count <= 1 {
            tableView.reloadSections([0, 1], with: .automatic)
        } else {
            tableView.reloadData()
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
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
