//
//  ViewController.swift
//  CountryDemo
//

import UIKit

class ViewController: UITableViewController {
    //MARK: - Variables
    var data = [CountryBaseModel]()
    var filteredData = [CountryBaseModel]()
    var networkingService = NetworkingService()

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Country List"
        setupInitialUI()
        getCountriesList()
    }
    
    //MARK: - Other methods
    func setupInitialUI(){
        // Set up the search controller
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func getCountriesList(){
        networkingService.getCountriesAPI { result in
            switch result {
            case .success(let countries):
                self.data = countries
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                // Handle the error
                DispatchQueue.main.async {
                    self.showErrorAlert(message: error.localizedDescription)
                }
            }
        }
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
//MARK: - Tableview methods
extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredData.count
        }
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        if isFiltering() {
            cell.setCellView(model: filteredData[indexPath.row])
        } else {
            cell.setCellView(model: data[indexPath.row])
        }
        return cell
    }
}

//MARK: - UISearchResults methods
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }

    func filterContentForSearchText(_ searchText: String) {
        filteredData = data.filter { $0.name?.localizedCaseInsensitiveContains(searchText) ?? false || $0.capital?.localizedCaseInsensitiveContains(searchText) ?? false}
        tableView.reloadData()
    }

    func isFiltering() -> Bool {
        let searchController = navigationItem.searchController
        return searchController?.isActive ?? false && !searchBarIsEmpty()
    }

    func searchBarIsEmpty() -> Bool {
        return navigationItem.searchController?.searchBar.text?.isEmpty ?? true
    }
}

//MARK: - Transition methods
extension ViewController {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        tableView.reloadData()
    }
}
