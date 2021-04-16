//
//  MLInitialViewController.swift
//  Pods
//
//  Created by Juan Pablo Hernandez on 15/04/2021.
//

import UIKit

public class MLInitialViewController: UIViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()

        startLibrary()
    }
    
    func startLibrary() {

        let abmTitlesViewController = MLABMTitlesViewController()
        abmTitlesViewController.title = "New item"
        
        let listViewController = MLListViewController()
        listViewController.title = "List of items"
        
        let searchViewController = MLSearchViewController()
        searchViewController.title = "Search items"
        
        let newItemNavController = UINavigationController(rootViewController: abmTitlesViewController)
        newItemNavController.title = "New item"
        newItemNavController.tabBarItem.image = UIImage(named: "ConvertIcon")
        
        let listNavController = UINavigationController(rootViewController: listViewController)
        listNavController.title = "List"
        listNavController.tabBarItem.image = UIImage(named: "MapIcon")
        
        let searchNavController = UINavigationController(rootViewController: searchViewController)
        searchNavController.title = "Search"
        searchNavController.tabBarItem.image = UIImage(named: "MapIcon")
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [newItemNavController, listNavController, searchNavController]
        
        UIApplication.shared.windows[0].rootViewController = tabBarController
        
    }



}
