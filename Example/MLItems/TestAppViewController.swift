//
//  TestAppViewController.swift
//  MLItems_Example
//
//  Created by Juan Pablo Hernandez on 14/04/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import MLItems

class TestAppViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        startLibrary()
    }

    func startLibrary() {
        let initialViewController = MLInitialViewController()
        UIApplication.shared.windows[0].rootViewController = initialViewController
    }

}
