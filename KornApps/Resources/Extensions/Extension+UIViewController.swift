//
//  Extension+UIViewController.swift
//  KornApps
//
//  Created by owner on 23/01/2023.
//

import UIKit

extension UIViewController {
  func screen() -> UIScreen? {
    var parent = self.parent
    var lastParent = parent
    
    while parent != nil {
      lastParent = parent
      parent = parent!.parent
    }
    
    return lastParent?.view.window?.windowScene?.screen
  }
}
