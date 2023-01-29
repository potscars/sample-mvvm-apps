//
//  Extension+UIView.swift
//  KornApps
//
//  Created by owner on 19/01/2023.
//

import Foundation
import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach { v in
            addSubview(v)
        }
    }
}
