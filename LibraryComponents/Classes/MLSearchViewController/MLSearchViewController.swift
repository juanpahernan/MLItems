//
//  MLSearchViewController.swift
//  Pods
//
//  Created by Juan Pablo Hernandez on 15/04/2021.
//

import UIKit

class MLSearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet private var contentView: UIView!
    
    private var filteredItems = [MLItem]() // TODO - MLItem

    override func viewDidLoad() {
        super.viewDidLoad()

        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search items"
        searchController.searchBar.delegate = self
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationItem.searchController = searchController
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(searchBar.text ?? "") {
            let listViewController = MLListViewController()
            listViewController.title = "Filtered results"
            listViewController.setList(list: self.filteredItems)
            self.navigationController?.pushViewController(listViewController, animated: true)
        }
    }
    
    private func getItemsFromCoreDataFiltered(filterText: String) -> [MLItem] {
//        TODO - CoreData
        let defaults = UserDefaults.standard
        var list = defaults.mLItemsArray(forKey: MLABMImageUploadViewController.arrayKey) ?? [MLItem]()
        list = list.filter({ $0.title.contains(filterText)})
        return list
    }
    
    private func search(_ text: String, completion: (() -> Void)? = nil) {
        filteredItems = getItemsFromCoreDataFiltered(filterText: text)
        if let completion = completion {
            completion()
        }
    }

}

