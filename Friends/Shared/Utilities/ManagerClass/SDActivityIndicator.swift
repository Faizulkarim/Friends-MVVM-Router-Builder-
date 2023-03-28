//
//  SDActivityIndicator.swift
//  Friends
//
//  Created by Md Faizul karim on 28/3/23.
//


import UIKit
import NVActivityIndicatorView

fileprivate var thisView: UIView?

extension UIViewController {
    
    func addLoadIndicator() {
        removeLoadIndicator()
        thisView = UIView(frame: UIScreen.main.bounds)
        let otActivityIndicatorFrame = CGRect(x: thisView!.frame.width/2 - 25, y: thisView!.frame.height/2 - 25, width: 50, height: 50)
        let otActivityIndicator = NVActivityIndicatorView(frame: otActivityIndicatorFrame, type: .ballRotateChase, color: UIColor.black, padding: 10)
        otActivityIndicator.startAnimating()
        thisView!.addSubview(otActivityIndicator)
        thisView?.backgroundColor = UIColor.init(named: "KCAppBackground")?.withAlphaComponent(0.2)
        view.addSubview(thisView!)
    }
    
    func removeLoadIndicator() {
        thisView?.removeFromSuperview()
        thisView = nil
    }
    
}
