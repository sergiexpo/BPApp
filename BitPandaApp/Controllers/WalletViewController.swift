//
//  WalletViewController.swift
//  BitPandaApp
//
//  Created by Sergi Exposito on 3/10/21.
//

import UIKit

class WalletViewController: UIViewController, UIGestureRecognizerDelegate {
    //MARK: - IBOutlets
    @IBOutlet weak var titleLabelWallets: UILabel!
    @IBOutlet weak var tableViewWallets: UITableView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var animationSection : Int?
    
    var walletsList = [Wallet]() {
        didSet{
            DispatchQueue.main.async {
                self.tableViewWallets.reloadData()
            }
        }
    }
    
    var expandGroups : [Bool] = []
    var walletGroups = [String]() {
        didSet{
            self.expandGroups.removeAll()
            self.expandGroups = self.initExpandGroupdList(groups: self.walletGroups)
            DispatchQueue.main.async {
                self.tableViewWallets.reloadData()
            }
        }
    }
    
    
    // MARK: -Lifeccycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        initWalletsList()
        initWalletGroups()
        titleLabelWallets.text = "Wallets"
        tableViewWallets.delegate = self
        tableViewWallets.dataSource = self
    }
    
    
    func initWalletsList(){
        self.walletsList = DataManager.shared.getWalletDataScreen()
        self.walletsList = DataManager.shared.sortWalletsByBalance(self.walletsList)
        let generalAssetsList = DataManager.shared.getAssetDataScreen()
        self.walletsList = DataManager.shared.getAllWalletsLogo(walletList: self.walletsList, assetList: generalAssetsList)
        self.walletsList = DataManager.shared.getAllWalletsDarkLogo(walletList: self.walletsList, assetList: generalAssetsList)
    }
    
    func initWalletGroups(){
        self.walletGroups.append(WalletTypes.cryptoWalletType.rawValue)
        self.walletGroups.append(WalletTypes.commoWalletType.rawValue)
        self.walletGroups.append(WalletTypes.fiatWalletType.rawValue)
    }
    
    func initExpandGroupdList(groups: [String]) -> [Bool]{
        var list : [Bool] = []
        if (groups.count > 0){
            for _ in 0...groups.count{
                list.append(false)
            }
        }
        return list
    }
    
    
}

// MARK: -Extension functions
extension WalletViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        walletGroups.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // walletsList.count
        if expandGroups.count > 0 {
            return self.expandGroups[section] ? getRowsForGroup(wallets: walletsList, group: walletGroups[section]) : 0
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cellType = (walletGroups[indexPath.section] == WalletTypes.fiatWalletType.rawValue) ? "FiatWalletViewCell" : "WalletViewCell"
        
        
        let walletsForGroup = getWalletsForGroup(wallets: walletsList, group: walletGroups[indexPath.section])
        
        let cell = tableViewWallets.dequeueReusableCell(withIdentifier: cellType) as? WalletViewCell
        
        if(indexPath.row < walletsForGroup.count){
            cell?.configure(wallet: walletsForGroup[indexPath.row])
            cell?.separatorInset = UIEdgeInsets(top: 0, left: cell!.bounds.size.width, bottom: 0, right: 0)
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height))
        footerView.backgroundColor = UIColor.init(named: "white_1")
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 12, y: 5, width: headerView.frame.width-60, height: headerView.frame.height-10)
        label.text = walletGroups[section]
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .white
        
        let labelIcon = UILabel()
        labelIcon.frame = CGRect.init(x: headerView.frame.maxX - 38, y: 5, width: 28, height: headerView.frame.height-10)
        
        labelIcon.text = expandGroups[section] ? "-" : "+"
        labelIcon.font = UIFont.boldSystemFont(ofSize: 32.0)
        labelIcon.textColor = .white
        
        headerView.addSubview(label)
        headerView.addSubview(labelIcon)
        headerView.layer.cornerRadius = 5
        headerView.backgroundColor = UIColor.init(named: "green_1")
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapRecognizer.delegate = self
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        headerView.tag = section
        headerView.addGestureRecognizer(tapRecognizer)
        
        return headerView
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if let currrentSection = sender.view?.tag  {
            expandGroups[currrentSection] = !expandGroups[currrentSection]
            animationSection = currrentSection
        }
        DispatchQueue.main.async {
            self.tableViewWallets.reloadData()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func getRowsForGroup(wallets: [Wallet], group: String) -> Int{
        return wallets.filter{$0.type == group}.count
    }
    
    func getWalletsForGroup(wallets: [Wallet], group: String) -> [Wallet]{
        return wallets.filter{$0.type == group}
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.section == animationSection {
            
            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -50, 0, -50)
            
            cell.layer.transform = rotationTransform
            
            UIView.animate(withDuration: 0.5, animations: { cell.layer.transform = CATransform3DIdentity })
        }
    }
    
}
