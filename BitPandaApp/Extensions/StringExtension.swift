//
//  StringExtension.swift
//  BitPandaApp
//
//  Created by Sergi Exposito on 4/10/21.
//

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
