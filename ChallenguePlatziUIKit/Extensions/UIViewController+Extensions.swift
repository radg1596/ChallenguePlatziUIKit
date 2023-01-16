//
//  UIViewController+Extensions.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 15/01/23.
//

import UIKit

extension UIViewController {

    func addOneChild(viewController: UIViewController, contentView: UIView) {
        viewController.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.addSubview(viewController.view)
        addChild(viewController)
        viewController.didMove(toParent: self)
        viewController.view.frame = contentView.bounds
    }

}
