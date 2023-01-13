//
// UICollectionViewCell+Extensions
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 13/01/23.
//

import UIKit

extension UICollectionViewCell {

    /// Returns the identifier using by default the own name of class
    /// For example: `MyCollectionViewCell` class
    /// `MyCollectionViewCell`.defaultIdentifier -> "MyCollectionViewCell"
    static var defaultIdentifier: String {
        String(describing: Self.self)
    }

}
