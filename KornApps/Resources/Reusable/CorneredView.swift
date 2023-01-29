//
//  CorneredView.swift
//  KornApps
//
//  Created by owner on 21/01/2023.
//

import UIKit

class CorneredView: UIView {
    
    private var enableShadow: Bool = false
    private var cornerRadius: CGFloat = 0.0
    
    init(_ cornerRadius: CGFloat, enableShadow: Bool = false) {
        
        self.cornerRadius = cornerRadius
        self.enableShadow = enableShadow
        
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setupInitial()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if enableShadow {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.25
            layer.shadowOffset = CGSize(width: 1, height: 1)
            layer.shadowRadius = 3
        }
    }
    
    private func setupInitial() {
        layer.cornerRadius = self.cornerRadius
    }
}
