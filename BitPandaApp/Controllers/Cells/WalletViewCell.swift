//
//  WalletViewCell.swift
//  BitPandaApp
//
//  Created by Sergi Exposito on 3/10/21.
//

import UIKit
import PocketSVG

class WalletViewCell:UITableViewCell{
    
    //MARK: - IBOutlets
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var viewCellWallet: UIView!
    @IBOutlet weak var labelDefault: UILabel!
    @IBOutlet weak var stackViewCellWallet: UIStackView!
    
    // MARK: -Lifeccycle functions
    override func prepareForReuse() {
        super.prepareForReuse()
        iconView.subviews.forEach({ $0.removeFromSuperview() })
        nameLabel.text = nil
        symbolLabel.text = nil
        balanceLabel.text = nil
        labelDefault.text = nil
        nameLabel.textColor = .label
        symbolLabel.textColor = .label
        balanceLabel.textColor = UIColor.init(named: "green_2")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewCellWallet.layer.cornerRadius = 8.0
        viewCellWallet.showShadow()
        labelDefault.text = nil
    }
    
    func configure(wallet: Wallet){
        
        let logoUrl = (DataManager.shared.isAppInDarkMode()) ? wallet.logo_dark : wallet.logo
        
        if let icon = logoUrl {
            iconView.addSubview(DataManager.shared.getSVGImageFromURL(url: icon, view: iconView))
        }
        nameLabel.text = wallet.name
        symbolLabel.text = wallet.symbol
        balanceLabel.text = wallet.balance
        if(wallet.isDefault){
            labelDefault.text = "Default"
        }
        if(wallet.type == WalletTypes.fiatWalletType.rawValue){
            nameLabel.textColor = .white
            symbolLabel.textColor = .white
            balanceLabel.textColor = .white
            stackViewCellWallet.backgroundColor = UIColor.init(named: "green_2")
            stackViewCellWallet.layer.cornerRadius = 8.0
        }
    }
    
    
}

