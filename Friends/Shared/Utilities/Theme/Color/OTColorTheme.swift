//
//  OTColorTheme.swift
//  Friends
//
//  Created by Md Faizul karim on 28/3/23.
//


import UIKit

struct OTColorTheme: ColorTheme {
    var clearColor: UIColor {
        return .clear
    }
    var colorPrimaryWhite : UIColor? {
        return UIColor.init(named: "PrimaryWhite")
    }
    
    var colorPrimaryBlack : UIColor? {
        return UIColor.init(named: "PrimaryBlack")
    }
    
    
    
}
