//
//  UIView+Extension.swift
//  Friends
//
//  Created by Md Faizul karim on 28/3/23.
//


import UIKit

extension UIView {
    //MARK: ADD Border
    func addBorder(color: UIColor? = UIColor.clear, width: CGFloat, radius: CGFloat) {
            layer.borderColor    = color!.cgColor
            layer.borderWidth    = width
            layer.cornerRadius   = radius
        }
  //MARK: ADD Shadow
    func addShadow(color: UIColor, opacity: Float, sizeX: CGFloat, sizeY: CGFloat, shadowRadius: CGFloat) {
            layer.shadowColor   = color.cgColor
            layer.shadowOpacity = opacity
            layer.shadowOffset  = CGSize(width: sizeX, height: sizeY)
            layer.shadowRadius  = shadowRadius
        }
    
  //MARK: Custom Tap Action
    fileprivate typealias ReturnGestureAction = (() -> Void)?
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer1"
    }
    fileprivate var tapGestureRecognizerAction: ReturnGestureAction? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? ReturnGestureAction
            return tapGestureRecognizerActionInstance
        }
    }
    
    func handleTapToAction(action: (() -> Void)?) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGestureHanldeAction))
        self.tapGestureRecognizerAction = action
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(gesture)
    }

    @objc func tapGestureHanldeAction() {
        if let action = self.tapGestureRecognizerAction {
            action?()
        } else {

        }
    }


}

protocol ReusableView {}
extension ReusableView where Self: UIView {
    static var nameId: String {
        return String(describing: self)
    }
}

extension UIView: ReusableView {}


