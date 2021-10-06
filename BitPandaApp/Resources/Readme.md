# Bitpanda iOS Dev Test.

Create a small lightweight app that displays the data in the attached Masterdata file. The app must have at least 2 screens (AssetsScreen, WalletsScreen) and it should be easy to switch between them.
You can use any library you wish to achieve this task. As for the UI please DO NOT USE __SwiftUI__ 

## Asset Screen

The asset screen must display a list of the cryptocoins, commodities and fiats. The following requirements must be fulfilled:

### General:

- filtering between each of the assets (show only cryptocoins, commodities or fiats). **OK**

### Cryptocoin, Commodities:

- Each list item must contain the asset's icon, name, symbol, average price.  **OK**
- Each price must have the number of decimals described by precision for fiat price (see cryptocoin/commodity properties in the Masterdata). **OK**
- Each price must also show the fiat symbol, as the prices are in euro fiat. **OK**
- Each price must take the regional location of the device into account for formatting. For example 1298.99 euros in Austria would be formatted to 1.298,99 € but in the USA, it would be formatted to $1,298.99. **OK**

### Fiats:

- Each list item must contain the fiat's icon, name, symbol . **OK**
- Only show the fiat that has wallets (see fiat properties in the Masterdata). **OK**

## Wallets Screen

The wallets screen must display a list of ALL wallets available grouped by fiat wallets, wallets and commodity wallets. The following requirements must be fulfilled:

### General:

- Each wallet must be in its proper group. **OK**
- It is up to you to decide how grouping is achieved, either by showing multiple lists or grouped items and then opening a new screen with the list of the corresponding wallets on selection etc. **OK**
- In each wallet group, the wallets must be sorted in a descending order by balance. **OK**

### Fiat Wallets, Wallets, Commodity Wallets:

- Each list item must contain the wallet's name, asset symbol, asset icon and the balance. **OK**
- If the wallet is the default wallet (see properties in the Masterdata), mark it in a meaningful and visible way. **OK**
- Do not display deleted wallets (see properties in the Masterdata). **OK**
- Make sure the fiat wallets are design-wise distinguishable from wallets or commodity wallets. **OK**
 

## Bonus:
- Implement a nice UI with animations. **OK**
- Fully support darkmode while taking into account the right logo for each mode.


GOOD LUCK!

