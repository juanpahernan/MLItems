//
//  MLABMTitlesViewController.swift
//  MLItems
//
//  Created by Juan Pablo Hernandez on 14/04/2021.
//

import UIKit

class MLABMTitlesViewController: UIViewController {
    
    static let titleKey = "Title"
    static let subtitleKey = "Subtitle"
    static let priceKey = "Price"
    static let descKey = "Descriptions"
    static let imageKey = "Image"
    
    @IBOutlet private var nextButton: UIButton!
    @IBOutlet private var prevButton: UIButton!
    @IBOutlet private var addItemButton: UIButton!
    @IBOutlet private var contentView: UIView!
    
    private var defaults: UserDefaults?
    private var stepsArray = [String]()
    private var step = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeArray()
        defaults = UserDefaults.standard
        if #available(iOS 11.0, *){navigationItem.backButtonTitle = "Back"}
    }


    @IBAction func nextButtonPressed(sender: UIButton) {
        saveUserDefaults()
        nextStep()
    }
    
    @IBAction func prevButtonPressed(sender: UIButton) {
        saveUserDefaults()
        prevStep()
    }
    
    @IBAction func addItemButtonPressed(sender: UIButton) {
        createViewWithText(stepsArray[step])
        nextButton.isHidden = false
        addItemButton.isHidden = true
    }
    
    private func initializeArray() {
        stepsArray.append(MLABMTitlesViewController.titleKey)
        stepsArray.append(MLABMTitlesViewController.subtitleKey)
        stepsArray.append(MLABMTitlesViewController.priceKey)
        stepsArray.append(MLABMTitlesViewController.descKey)
    }
    
    private func nextStep() {
        step += 1
        prevButton.isHidden = false
        if (step < stepsArray.count){
            createViewWithText(stepsArray[step])
        } else {
            self.step = stepsArray.count - 1
            navigateNextController()
        }
    }
    
    private func prevStep() {
        step -= 1
        if (step == 0) { prevButton.isHidden = true }
        if (step < 0) { step = 0 }
        else { createViewWithText(stepsArray[step]) }
    }
    
    private func createViewWithText(_ text: String) {
        if (contentView.subviews.count > 0) {
            contentView.subviews.first?.removeFromSuperview()
        }
        let titleView = MLTitleView(frame: contentView.bounds)
        titleView.titleLabel.text = text
        titleView.titleTextField.placeholder = text
        if (text == "Price") {
            titleView.titleTextField.keyboardType = .decimalPad
        }
        titleView.titleTextField.text = defaults?.string(forKey: text)
        contentView.addSubview(titleView)
    }
    
    private func navigateNextController() {
        let controller = MLABMImageUploadViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func saveUserDefaults() {
        let mlTitleView = contentView.subviews.first as! MLTitleView
        let textFieldText = mlTitleView.titleTextField.text
        defaults?.setValue(textFieldText, forKey: stepsArray[step])
    }

}
