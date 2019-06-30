//
//  WeatherSearchTableViewController.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/25/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import UIKit
import CoreLocation

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
        
        viewModel?.loadWeatherHistory()
        tableView.reloadData()
    }
    
    // MARK: - Override
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)

        tableView.setEditing(editing, animated: animated)
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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.keyboardDismissMode = .onDrag
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Action
    
    @IBAction func didClickSearchCurrentLocation(_ sender: Any) {
        viewModel?.getCurrentLocationIfAvailable()
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
            return viewModel.searchHistory.count
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
        cell.detailTextLabel?.text?.removeAll()
        
        switch tableViewSection {
        case .search:
            if indexPath.row == 0 {
                cell.textLabel?.text = "Search by City \"\(viewModel.searchKeywords)\""
            } else {
                cell.textLabel?.text = "Search by Zip Code \"\(viewModel.searchKeywords)\""
            }
        case .searchHistory:
            let weatherSearch = viewModel.searchHistory[indexPath.row]
            switch weatherSearch.searchType {
            case .cityName(name: let name):
                cell.textLabel?.text = name
                cell.detailTextLabel?.text = "City"
            case .zipCode(code: let code):
                cell.textLabel?.text = code
                cell.detailTextLabel?.text = "Zip Code"
            case .location(lat: let lat, lon: let lon):
                cell.textLabel?.text = "\(lat) \(lon)"
                cell.detailTextLabel?.text = "Location"
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
                showWeatherDetailActions(with: weatherSearchInfo)
            } else {
                let weatherSearchInfo = WeatherSearch(searchType: .zipCode(code: viewModel.searchKeywords))
                showWeatherDetailActions(with: weatherSearchInfo)
            }
        case .searchHistory:
            let weatherSearch = viewModel.searchHistory[indexPath.row]
            showWeatherDetailActions(with: weatherSearch, isSaveHistory: false)
            break
        case .total:
            break
        }
    }
    
    // MARK: Table View Deleteion
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        guard let tableViewSection = TableViewSection(rawValue: indexPath.section) else {
            return .none
        }
        
        if tableViewSection == .searchHistory {
            return .delete
        }
        
        return .none
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel?.removeWeatherHistory(atIndex: indexPath.row)
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
    
    func showWeatherDetailActions(with weatherSearch: WeatherSearch, isSaveHistory: Bool = true) {
        if isSaveHistory {
            viewModel?.saveWeatherHistory(weatherSearch)
        }

        coordinator?.showWeatherDetail(with: weatherSearch)
        tableView.reloadData()
    }
}

// MARK: - UISearchBarDelegate

extension WeatherSearchTableViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.searchKeywords.removeAll()
        reloadTableViewWhenSearchTextChange(searchText: "")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.searchKeywords = searchText
        reloadTableViewWhenSearchTextChange(searchText: searchText)
    }
}

// MARK: - UISearchResultsUpdating

extension WeatherSearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.isActive {
            setEditing(false, animated: true)
        }
    }
}

// MARK: - WeatherSearchViewModelProtocal

extension WeatherSearchTableViewController: WeatherSearchViewModelProtocal {
    func didRecieveCurrentLocation(_ location: CLLocationCoordinate2D) {
        let weatherSearchInfo = WeatherSearch(searchType: .location(lat: location.latitude, lon: location.longitude))
        showWeatherDetailActions(with: weatherSearchInfo)
    }
    
    func didFailGettingCurrentLocation() {
        
    }
}
