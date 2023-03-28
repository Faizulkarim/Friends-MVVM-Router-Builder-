//
//  BaseView.swift
//  Friends
//
//  Created by Md Faizul karim on 28/3/23.
//


import Foundation
import UIKit

// MARK: BaseView
class BaseView: UIView {

    var theme: Theme?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {}
}
