//
//  AssetViewCell.swift
//  BitPandaApp
//
//  Created by Sergi Exposito on 1/10/21.
//

import UIKit
import PocketSVG

class AssetViewCell:UITableViewCell{
    
    //MARK: - IBOutlets
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var avgPriceLabel: UILabel!
    @IBOutlet weak var viewCellAsset: UIView!
    
    // MARK: -Lifeccycle functions
    override func prepareForReuse() {
        super.prepareForReuse()
        iconView.subviews.forEach({ $0.removeFromSuperview() })
        nameLabel.text = nil
        symbolLabel.text = nil
        avgPriceLabel.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewCellAsset.layer.cornerRadius = 8.0
        viewCellAsset.showShadow()
        
        let screenWidth = DataManager.shared.getCurrentScreenWidhtSize()
        if (screenWidth < 375 ){
            adjustUIToSmallScreen()
        }
    }
    
    func configure(asset: Asset){
        let logoUrl = (DataManager.shared.isAppInDarkMode()) ? asset.logo_dark : asset.logo
        iconView.addSubview(DataManager.shared.getSVGImageFromURL(url: logoUrl, view: iconView))
        nameLabel.text = asset.name
        symbolLabel.text = asset.symbol
        if let price = asset.averagePrice,
           let nDecimals = asset.precisionFiatPrice{
            avgPriceLabel.text = DataManager.shared.currencyFormatter(price, nDecimals)
        }
    }
    
    func adjustUIToSmallScreen(){
        nameLabel.font = nameLabel.font.withSize(15)
        symbolLabel.font = symbolLabel.font.withSize(15)
    }
    
}
