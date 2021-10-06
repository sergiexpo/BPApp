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
    let cryptocoins, commodities: [Commodity]
    let fiats: [Fiat]
    let wallets, commodityWallets: [WalletMD]
    let fiatwallets: [FiatWalletMD]

    enum CodingKeys: String, CodingKey {
        case cryptocoins, commodities, fiats, wallets
        case commodityWallets = "commodity_wallets"
        case fiatwallets
    }
}

// MARK: - Commodity
struct Commodity: Codable {
    let type: String
    let attributes: CommodityAttributes
    let id: String
}

// MARK: - CommodityAttributes
struct CommodityAttributes: Codable {
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

// MARK: - Fiat
struct Fiat: Codable {
    let type: String
    let attributes: FiatAttributes
    let id: String
}

// MARK: - FiatAttributes
struct FiatAttributes: Codable {
    let symbol, name, logo, logo_dark: String
    let has_wallets: Bool
}

// MARK: - Wallet
struct WalletMD: Codable {
    let type: String
    let attributes: CommodityWalletAttributes
    let id: String
}

// MARK: - CommodityWalletAttributes

struct CommodityWalletAttributes: Codable {
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


