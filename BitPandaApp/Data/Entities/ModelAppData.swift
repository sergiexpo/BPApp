//
//  ModelAppData.swift
//  BitPandaApp
//
//  Created by Sergi Exposito on 2/10/21.
//

import UIKit

/*protocol GeneralAsset{
    var id: String {get set}
    var type: String {get set}
    var name: String {get set}
    var symbol: String {get set}
    var logo: String {get set}
    var logo_dark: String {get set}
    
} */


class Asset {
    var id: String
    var type: String
    var name: String
    var symbol: String
    var logo: String
    var logo_dark: String
    var averagePrice: String?
    var precisionFiatPrice: Int?
    var has_wallets: Bool?
    
    init(generalAsset: Commodity, typeWallet: String) {
        id = generalAsset.id
        type = typeWallet
        name = generalAsset.attributes.name
        symbol = generalAsset.attributes.symbol
        logo = generalAsset.attributes.logo
        logo_dark = generalAsset.attributes.logoDark
        averagePrice = generalAsset.attributes.averagePrice
        precisionFiatPrice = generalAsset.attributes.precisionFiatPrice
        has_wallets = nil
    }
    
    init(fiatAsset: Fiat, typeWallet: String) {
        id = fiatAsset.id
        type = typeWallet
        name = fiatAsset.attributes.name
        symbol = fiatAsset.attributes.symbol
        logo = fiatAsset.attributes.logo
        logo_dark = fiatAsset.attributes.logo_dark
        averagePrice = nil
        precisionFiatPrice = nil
        has_wallets = fiatAsset.attributes.has_wallets
    }
}


class Wallet {
    var walletId: String
    var type: String
    var name: String
    var symbol: String
    var assetID: String
    var logo: String?
    var logo_dark: String?
    var balance: String
    var isDefault: Bool
    var deleted: Bool?
    
    init(wallet: WalletMD, typeWallet: String){
        walletId = wallet.id
        type = typeWallet
        name = wallet.attributes.name
        symbol = wallet.attributes.cryptocoinSymbol
        assetID = wallet.attributes.cryptocoinID
        logo = nil
        logo_dark = nil
        balance = wallet.attributes.balance
        isDefault = wallet.attributes.isDefault
        deleted = wallet.attributes.deleted
    }
    
    init(fiatWallet: FiatWalletMD, typeWallet: String){
        walletId = fiatWallet.id
        type = typeWallet
        name = fiatWallet.attributes.name
        symbol = fiatWallet.attributes.fiatSymbol
        assetID = fiatWallet.attributes.fiatID
        logo = nil
        logo_dark = nil
        balance = fiatWallet.attributes.balance
        isDefault = false
        deleted = nil
    }
    
    
    func setAssetLogo(wallet: Wallet, asset: Asset){
        if (wallet.assetID == asset.id) {
            wallet.logo = asset.logo
        }
    }
    
    func setAssetDarkLogo(wallet: Wallet, asset: Asset){
        if (wallet.assetID == asset.id) {
            wallet.logo_dark = asset.logo_dark
        }
    }

    
}


