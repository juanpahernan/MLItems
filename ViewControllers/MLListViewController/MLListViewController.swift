//
//  MLListViewController.swift
//  Pods
//
//  Created by Juan Pablo Hernandez on 15/04/2021.
//

import UIKit

class MLListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet private var tableView: UITableView!
    private var list = [MLItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        if list.isEmpty {
            getItemsFromCoreData()
            NotificationCenter.default.addObserver(self, selector: #selector(getItemsFromCoreData), name: NSNotification.Name("updateItemsList"), object: nil)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.register(UINib(nibName: "MLItemTableViewCell", bundle: nibBundle), forCellReuseIdentifier: "itemCell")
        
// TODO - CoreData
        let item: MLItem = list[indexPath.row]
        
        let cell: MLItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "itemCell") as! MLItemTableViewCell
        cell.itemTitle.text = item.title
        cell.itemSubtitle.text = item.subtitle
        cell.itemPrice.text = NSNumber(value: item.price).toCurrency()
        
        if let image = item.getImage() {
            cell.itemImageView?.isHidden = false
            cell.itemImageView?.image = image
        } else {
            cell.itemImageView?.isHidden = true
        }
        
        return cell
    }
    
    
    @objc private func getItemsFromCoreData() {
// TODO - CoreData
        let defaults = UserDefaults.standard
        self.list = defaults.mLItemsArray(forKey: MLABMImageUploadViewController.arrayKey) ?? [MLItem]()
        tableView?.reloadData()
    }
    
    public func setList(list: [MLItem]) { // TODO - CoreData
        self.list = list
    }

}
