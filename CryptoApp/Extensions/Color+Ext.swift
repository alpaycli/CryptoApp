//
//  Color+Ext.swift
//  CryptoX
//
//  Created by Alpay Calalli on 06.09.23.
//

import SwiftUI

extension UIColor {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accentColor = UIColor(named: "AccentColor")
    let backgroundColor = UIColor(named: "BackgroundColor")
    let greenColor = UIColor(named: "GreenColor")
    let redColor = UIColor(named: "RedColor")
    let secondaryTextColor = UIColor(named: "SecondaryTextColor")
}
