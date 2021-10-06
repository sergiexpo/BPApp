//
//  DataManager.swift
//  BitPandaApp
//
//  Created by Sergi Exposito on 1/10/21.
//

import UIKit
import PocketSVG

class DataManager: Codable{
    // MARK: - SINGLETON start -
    static var shared: DataManager = {
        return DataManager()
    }()
    private init() {}
    // MARK: - SINGLETON end -
    
    var cryptocoinsList = [AssetMD]()
    var commoditiesList = [AssetMD]()
    var fiatsList = [FiatMD]()
    var walletsList = [WalletMD]()
    var commodityWalletsList = [WalletMD]()
    var fiatWalletsList = [FiatWalletMD]()
    
    func getAllMasterData(){
        guard let path = Bundle.main.path(forResource: "Mastrerdata", ofType: "json") else{ return}
        let url = URL(fileURLWithPath: path)
        
        do{
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(Response.self, from: data)
            getAllAppData(response)
        }catch{
            print(error)
        }
    }
    
    func getAllAppData(_ response : Response){
        getAllCryptocoins(response)
        getAllCommodities(response)
        getAllFiats(response)
        getAllWallets(response)
        getAllCommodityWallets(response)
        getAllFiatWallets(response)
        
    }
    
    func getAllCryptocoins(_ response : Response){
        response.data.attributes.cryptocoins.forEach{
            cryptocoinsList.append($0)
        }
    }
    
    func getAllCommodities(_ response : Response){
        response.data.attributes.commodities.forEach{
            commoditiesList.append($0)
        }
    }
    
    func getAllFiats(_ response : Response){
        response.data.attributes.fiats.forEach{
            fiatsList.append($0)
        }
    }
    
    func getAllWallets(_ response : Response){
        response.data.attributes.wallets.forEach{
            walletsList.append($0)
        }
    }
    
    func getAllCommodityWallets(_ response : Response){
        response.data.attributes.commodityWallets.forEach{
            commodityWalletsList.append($0)
        }
    }
    
    func getAllFiatWallets(_ response : Response){
        response.data.attributes.fiatwallets.forEach{
            fiatWalletsList.append($0)
        }
    }
    
    func getAssetDataScreen() -> [Asset]{
        var list = [Asset]()
        cryptocoinsList.forEach{
            list.append(mapMDCommodityToAppAsset($0,AssetTypes.cryptoType.rawValue))
        }
        commoditiesList.forEach{
            list.append(mapMDCommodityToAppAsset($0, AssetTypes.commoType.rawValue))
        }
        fiatsList.forEach{
            if($0.attributes.has_wallets){
                list.append(mapMDFiatToAppFiatAsset($0,AssetTypes.fiatType.rawValue))
            }
        }
        return list
    }
    
    func mapMDCommodityToAppAsset(_ mdCommodity: AssetMD,_ typeWallet: String) -> Asset{
        return Asset(generalAsset: mdCommodity, typeWallet: typeWallet)
    }
    
    func mapMDFiatToAppFiatAsset(_ mdFiat: FiatMD,_ typeWallet: String) -> Asset{
        return Asset(fiatAsset: mdFiat, typeWallet: typeWallet)
    }
    
    func getWalletDataScreen() -> [Wallet]{
        var list = [Wallet]()
        walletsList.forEach{
            if !($0.attributes.deleted){
                list.append(mapMDWalletToAppWallet($0, WalletTypes.cryptoWalletType.rawValue))
            }
        }
        commodityWalletsList.forEach{
            if !($0.attributes.deleted){
                list.append(mapMDWalletToAppWallet($0, WalletTypes.commoWalletType.rawValue))
            }
        }
        fiatWalletsList.forEach{
            list.append(mapMDFiatWalletToAppFiatWallet($0, WalletTypes.fiatWalletType.rawValue))
        }
        return list
    }
    
    func mapMDWalletToAppWallet(_ mdWallet: WalletMD, _ typeWallet: String) -> Wallet{
        return Wallet(wallet: mdWallet, typeWallet: typeWallet)
    }
    
    func mapMDFiatWalletToAppFiatWallet(_ mdFiatWallet: FiatWalletMD, _ typeWallet: String) -> Wallet{
        return Wallet(fiatWallet: mdFiatWallet, typeWallet: typeWallet)
    }
    
    func sortWalletsByBalance(_ walletList : [Wallet]) -> [Wallet]{
        return walletList.sorted{$0.balance.localizedStandardCompare($1.balance) == .orderedDescending}
    }
    
    func getAllWalletsLogo(walletList: [Wallet], assetList: [Asset]) -> [Wallet]{
        var resultWalletList = [Wallet]()
        walletList.forEach{ wallet in
            assetList.forEach{ asset in
                wallet.setAssetLogo(wallet: wallet, asset: asset)
            }
            resultWalletList.append(wallet)
        }
        return resultWalletList
    }
    
    func getAllWalletsDarkLogo(walletList: [Wallet], assetList: [Asset]) -> [Wallet]{
        var resultWalletList = [Wallet]()
        walletList.forEach{ wallet in
            assetList.forEach{ asset in
                wallet.setAssetDarkLogo(wallet: wallet, asset: asset)
            }
            resultWalletList.append(wallet)
        }
        return resultWalletList
    }
    
    func currencyFormatter(_ number: String, _ nDecimals: Int) -> String{
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.minimumFractionDigits = nDecimals
        currencyFormatter.maximumFractionDigits = nDecimals
        currencyFormatter.locale = Locale.current
        let numberFormatted = currencyFormatter.string(from: Double(number)! as NSNumber)!
        return numberFormatted
    }
    
    func getSVGImageFromURL(url: String, view: UIView) -> SVGImageView{
        let url = URL(string: url)
        let svgImageView = SVGImageView.init(contentsOf: url!)
        svgImageView.frame = view.bounds
        svgImageView.contentMode = .scaleAspectFit
        return svgImageView
    }
    
    func isAppInDarkMode() -> Bool {
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return true
            }
            else {
                return false
            }
        }
        return false   // Default case, light mode
    }
    
    func getCurrentScreenWidhtSize() -> Int{
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        return Int (screenWidth)
    }
    
}
