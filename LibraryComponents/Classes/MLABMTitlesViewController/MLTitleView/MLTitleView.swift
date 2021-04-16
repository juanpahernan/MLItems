//
//  MLTitleView.swift
//  Pods
//
//  Created by Juan Pablo Hernandez on 15/04/2021.
//

import UIKit

class MLTitleView: UIView {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentView: UIView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    private func customInit() {
        let frameworkBundle = Bundle(for: MLABMTitlesViewController.self)
        let path = frameworkBundle.path(forResource: "MLItemsResources", ofType: "bundle")
        let resourceBundle = Bundle(url: URL(fileURLWithPath: path!))
        
        let view: UIView = resourceBundle?.loadNibNamed("MLTitleView", owner: self, options: nil)?.first as! UIView
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }

}
