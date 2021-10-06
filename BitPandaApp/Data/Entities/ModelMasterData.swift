//
//  ModelMasterData.swift
//  BitPandaApp
//
//  Created by Sergi Exposito on 1/10/21.
//

import UIKit

// MARK: - Response

struct Response: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let type: String
    let attributes: DataAttributes
}

// MARK: - DataAttributes
struct DataAttributes: Codable {
    let cryptocoins, commodities: [AssetMD]
    let fiats: [FiatMD]
    let wallets, commodityWallets: [WalletMD]
    let fiatwallets: [FiatWalletMD]
    
    enum CodingKeys: String, CodingKey {
        case cryptocoins, commodities, fiats, wallets
        case commodityWallets = "commodity_wallets"
        case fiatwallets
    }
}

// MARK: - AssetMD
struct AssetMD: Codable {
    let type: String
    let attributes: AssetMDAttributes
    let id: String
}

// MARK: - AssetMDAttributes
struct AssetMDAttributes: Codable {
    let symbol, name, averagePrice, logo, logoDark: String
    let precisionFiatPrice: Int
    
    enum CodingKeys: String, CodingKey {
        case symbol, name
        case averagePrice = "avg_price"
        case logo
        case logoDark = "logo_dark"
        case precisionFiatPrice = "precision_for_fiat_price"
    }
}

// MARK: - FiatMD
struct FiatMD: Codable {
    let type: String
    let attributes: FiatMDAttributes
    let id: String
}

// MARK: - FiatMDAttributes
struct FiatMDAttributes: Codable {
    let symbol, name, logo, logo_dark: String
    let has_wallets: Bool
}

// MARK: - Wallet
struct WalletMD: Codable {
    let type: String
    let attributes: WalletMDAttributes
    let id: String
}

// MARK: - WalletMDAttributes

struct WalletMDAttributes: Codable {
    let cryptocoinID, cryptocoinSymbol, balance: String
    let isDefault: Bool
    let name: String
    let deleted: Bool
    
    enum CodingKeys: String, CodingKey {
        case cryptocoinID = "cryptocoin_id"
        case cryptocoinSymbol = "cryptocoin_symbol"
        case balance
        case isDefault = "is_default"
        case name
        case deleted
    }
}

// MARK: - Fiatwallet
struct FiatWalletMD: Codable {
    let type: String
    let attributes: FiatwalletAttributes
    let id: String
}

// MARK: - FiatwalletAttributes
struct FiatwalletAttributes: Codable {
    let fiatID, fiatSymbol, balance, name: String
    
    enum CodingKeys: String, CodingKey {
        case fiatID = "fiat_id"
        case fiatSymbol = "fiat_symbol"
        case balance, name
    }
}


