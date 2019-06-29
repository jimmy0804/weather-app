//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/28/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import UIKit
import DeckTransition

class WeatherDetailViewController: UIViewController {
    
    enum TableViewRow: Int {
        case cityName
        case temperature
        case sunrise
        case sunset
        case humidity
        case wind
        case pressure
        case total
    }
    
    // MARK: - Outlet

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 50
            tableView.backgroundColor = .clear
            
            let nib = UINib(nibName: detailCellId, bundle: Bundle.main)
            tableView.register(nib, forCellReuseIdentifier: detailCellId)

            tableView.tableFooterView = UIView()
        }
    }

    @IBOutlet weak var spinner: UIActivityIndicatorView! {
        didSet {
            spinner.hidesWhenStopped = true
            spinner.stopAnimating()
        }
    }
    
    @IBOutlet weak var errorLabel: UILabel! {
        didSet {
            errorLabel.isHidden = true
            errorLabel.text = "Sorry, we couldn't find the weather information."
        }
    }
    // MARK: - Property
    
    let titleCellId = "WeatherDetailTitleTableViewCell"
    let detailCellId = "WeatherDetailTableViewCell"

    weak var coordinator: WeatherDetailCoordinator?
    var viewModel: WeatherDetailViewModel?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private var hasError = false {
        didSet {
            spinner.stopAnimating()
            tableView.isHidden = true
            errorLabel.isHidden = false
        }
    }
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        modalPresentationCapturesStatusBarAppearance = true
        viewModel?.getWeatherDetail()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        viewModel?.cancelGetWeather()
    }
}

// MARK: - UITableViewDataSource

extension WeatherDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard viewModel?.weatherViewModel != nil else {
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableViewRow.total.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewRow = TableViewRow(rawValue: indexPath.row) else {
            preconditionFailure("Error: Wrong table view row defined")
        }
        
        guard let weatherViewModel = viewModel?.weatherViewModel,
            let cell = tableView.dequeueReusableCell(withIdentifier: detailCellId, for: indexPath) as? WeatherDetailTableViewCell else {
            return UITableViewCell()
        }
        
        switch tableViewRow {
        case .cityName:
            let cell = tableView.dequeueReusableCell(withIdentifier: titleCellId, for: indexPath)
            cell.textLabel?.text = weatherViewModel.cityName
            return cell
        case .temperature:
            cell.config(leftTitle: "Temperature", leftDesc: weatherViewModel.temperature)
        case .sunrise:
            cell.config(leftTitle: "Sunrise", leftDesc: weatherViewModel.sunrise)
        case .sunset:
            cell.config(leftTitle: "Sunset", leftDesc: weatherViewModel.sunset)
        case .humidity:
            cell.config(leftTitle: "Humidity", leftDesc: weatherViewModel.humidity)
        case .pressure:
            cell.config(leftTitle: "Pressure", leftDesc: weatherViewModel.pressureInfo)
        case .wind:
            cell.config(leftTitle: "Wind", leftDesc: weatherViewModel.windInfo)
        case .total:
            break
        }
        
        return cell
    }
}

// MARK: - WeatherDetailViewModelProtocal

extension WeatherDetailViewController: WeatherDetailViewModelProtocal {
    func weatherDetailViewModel(_ viewModel: WeatherDetailViewModel, startsSearching search: WeatherSearch) {
        spinner.startAnimating()
    }
    
    func weatherDetailViewModel(_ viewModel: WeatherDetailViewModel, didFinishSearching search: WeatherSearch, withResult result: WeatherViewModel) {
        spinner.stopAnimating()
        tableView.reloadData()
    }
    
    func weatherDetailViewModel(_ viewModel: WeatherDetailViewModel, didFailedSearching search: WeatherSearch, withReason reason: String) {
        hasError = true
    }
}

// MARK: - DeckTransitionViewControllerProtocol

extension WeatherDetailViewController: DeckTransitionViewControllerProtocol {
    var scrollViewForDeck: UIScrollView {
        return tableView
    }
}
