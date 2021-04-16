//
//  MLABMImageUploadViewController.swift
//  Pods
//
//  Created by Juan Pablo Hernandez on 15/04/2021.
//

import UIKit

class MLABMImageUploadViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    static let arrayKey = "arrayKey"
    
    @IBOutlet private var imageView: UIImageView!
    
    private var itemTitle = ""
    private var itemSubtitle = ""
    private var itemPrice = 0.0
    private var itemDesc = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        itemTitle = defaults.string(forKey: MLABMTitlesViewController.titleKey)!
        itemSubtitle = defaults.string(forKey: MLABMTitlesViewController.subtitleKey)!
        itemPrice = defaults.double(forKey: MLABMTitlesViewController.priceKey)
        itemDesc = defaults.string(forKey: MLABMTitlesViewController.descKey)!
        
        if let imageData = defaults.object(forKey: MLABMTitlesViewController.imageKey) as? Data {
            imageView.image = UIImage(data: imageData)
        }
        
        self.title = "Upload image"
    }
    
    @IBAction func uploadImageButtonPressed(sender: UIButton) {
        let pickerView = UIImagePickerController()
        pickerView.allowsEditing = true
        pickerView.delegate = self
        pickerView.sourceType = .photoLibrary
        self.present(pickerView, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(sender: UIButton) {
        /// TODO - Implementar CoreData
        saveNewItem()
        updateListNotification()
        resetNavigation()
    }
    
    @IBAction func fakeItemsButtonPressed(sender: UIButton) {
        let numberOfItems = 100
        createFakeItems(NSNumber(value: numberOfItems))
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                                       didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage
        imageView.image = chosenImage
        saveImage(chosenImage)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func saveImage(_ image: UIImage) {
        UserDefaults.standard.setValue(UIImagePNGRepresentation(image),
                                       forKey: MLABMTitlesViewController.imageKey)
    }
    
    private func resetNavigation() {
        clearUserDefaults()
        
        let frameworkBundle = Bundle(for: MLABMTitlesViewController.self)
        let path = frameworkBundle.path(forResource: "MLItemsResources", ofType: "bundle")
        let resourceBundle = Bundle(url: URL(fileURLWithPath: path!))

        let abmTitlesViewController = MLABMTitlesViewController(nibName: "MLABMTitlesViewController", bundle: resourceBundle)
        abmTitlesViewController.title = "ABMTitles"
        
        navigationController?.setViewControllers([abmTitlesViewController], animated: true)
    }
    
    private func clearUserDefaults() {
//        let appDomain = Bundle.main.bundleIdentifier!
//        UserDefaults.standard.removePersistentDomain(forName: appDomain)
    }

    private func updateListNotification() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateItemsList"), object: nil)
    }
    
    private func saveNewItem() {
        let item = MLItem()
        item.title = itemTitle
        item.subtitle = itemSubtitle
        item.price = itemPrice
        item.desc = itemDesc
        item.setImage(imageView.image)
        
        let defaults = UserDefaults.standard
        var array: [MLItem]? = defaults.array(forKey: MLABMImageUploadViewController.arrayKey) as? [MLItem]
        if array == nil { array = [MLItem]() }
        array!.append(item)
        defaults.setMLItemsArray(array!, forKey: MLABMImageUploadViewController.arrayKey)
    }
    
    private func createFakeItems(_ number: NSNumber) {
        var array = UserDefaults.standard.mLItemsArray(forKey: MLABMImageUploadViewController.arrayKey) ?? [MLItem]()
        
        let image = imageView.image
        DispatchQueue.global(qos: .default).async {
            for i in 0...number.intValue {
//                 TODO - CoreData
                let item = MLItem()
                item.title = "Title \(i)"
                item.subtitle = "Subtitle \(i)"
                item.price = Double(i)
                item.desc = "Description \(i)"
                item.setImage(image)
                array.append(item)
            }
            UserDefaults.standard.setMLItemsArray(array, forKey: MLABMImageUploadViewController.arrayKey)
            self.updateListNotification()
        }
        
        
    }
}
