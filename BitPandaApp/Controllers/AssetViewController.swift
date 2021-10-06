//
//  AssetViewController.swift
//  BitPandaApp
//
//  Created by Sergi Exposito on 1/10/21.
//

import UIKit

class AssetViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var titleLabelAssets: UILabel!
    @IBOutlet weak var tableViewAssets: UITableView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var labelAssetShowed: UILabel!
    
    var generalAssetsList = DataManager.shared.getAssetDataScreen()
    var filteredAssetsList = [Asset]()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: -Lifeccycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        showInitialFilteredList()
        
        let origImage = UIImage(named: "Filter")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        filterButton.setImage(tintedImage, for: .normal)
        filterButton.tintColor = .white
        
        titleLabelAssets.text = "Assets"
        tableViewAssets.delegate = self
        tableViewAssets.dataSource = self
        
    }
    
    //MARK: - IBActions
    @IBAction func onfilterButtonPressed(_ sender: UIButton){
        showFilter(style: .actionSheet, title: "Filter", message: "Select an asset to show",
                   
                   filterCriptocoins:{action in
                    self.filteredAssetsList = self.generalAssetsList
                    self.filteredAssetsList.removeAll { !($0.type.contains(AssetTypes.cryptoType.rawValue))
                    }
                    self.tableViewAssets.reloadData()
                    self.labelAssetShowed.text = AssetTypes.cryptoType.rawValue
                   },
                   filterCommodities:{action in
                    self.filteredAssetsList = self.generalAssetsList
                    self.filteredAssetsList.removeAll { !($0.type.contains(AssetTypes.commoType.rawValue))
                    }
                    self.tableViewAssets.reloadData()
                    self.labelAssetShowed.text = AssetTypes.commoType.rawValue
                   },
                   filterFiats:{action in
                    self.filteredAssetsList = self.generalAssetsList
                    self.filteredAssetsList.removeAll { !($0.type.contains(AssetTypes.fiatType.rawValue))
                    }
                    self.tableViewAssets.reloadData()
                    self.labelAssetShowed.text = AssetTypes.fiatType.rawValue
                   }
        )
    }
    
    
    func showInitialFilteredList(){   // For example, show the screen with cryptocoins
        self.filteredAssetsList = self.generalAssetsList
        self.filteredAssetsList.removeAll { !($0.type.contains(AssetTypes.cryptoType.rawValue))}
        labelAssetShowed.text = AssetTypes.cryptoType.rawValue
    }
    
    
    func showFilter (style: UIAlertController.Style,
                    title: String,
                    message: String,
                    filterAll: ((UIAlertAction) -> Void)? = nil,
                    filterCriptocoins:((UIAlertAction) -> Void)? = nil,
                    filterCommodities:((UIAlertAction) -> Void)? = nil,
                    filterFiats:((UIAlertAction) -> Void)? = nil){
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: style)
        
        alert.addAction(UIAlertAction(title: AssetTypes.cryptoType.rawValue,
                                      style: .default,
                                      handler: filterCriptocoins))
        
        alert.addAction(UIAlertAction(title: AssetTypes.commoType.rawValue,
                                      style: .default,
                                      handler: filterCommodities))
        
        
        alert.addAction(UIAlertAction(title: AssetTypes.fiatType.rawValue,
                                      style: .default,
                                      handler: filterFiats))
        
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .destructive,
                                      handler: nil))
        
        present(alert, animated : true)
    }
    
    
}

extension AssetViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredAssetsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell = tableViewAssets.dequeueReusableCell(withIdentifier: "AssetViewCell") as? AssetViewCell
        if(indexPath.row < filteredAssetsList.count){
            cell?.configure(asset: filteredAssetsList[index])
            cell?.separatorInset = UIEdgeInsets(top: 0, left: cell!.bounds.size.width, bottom: 0, right: 0)
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
             let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -50, 0, -50)
             cell.layer.transform = rotationTransform
             UIView.animate(withDuration: 0.5, animations: { cell.layer.transform = CATransform3DIdentity })
         } 

    
    
}
