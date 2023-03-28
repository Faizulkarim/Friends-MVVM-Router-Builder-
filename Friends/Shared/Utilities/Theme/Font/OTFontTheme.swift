//
//  OTFontTheme.swift
//  Friends
//
//  Created by Md Faizul karim on 28/3/23.
//


import UIKit

struct OTFontTheme: FontTheme {
    var regularMontserrat: MontserratFonts = MontserratFonts.Regular
}

enum MontserratFonts: String {
    case Regular = "Montserrat-Regular"

    func font(_ size: CGFloat) -> UIFont {
        if let font = UIFont(name: self.rawValue, size: size) {
            return font
        }
        return UIFont.systemFont(ofSize: size)
    }
}
