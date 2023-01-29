//
//  FooterSpinnerCollectionReusableView.swift
//  KornApps
//
//  Created by owner on 26/01/2023.
//

import UIKit

class FooterSpinnerCollectionReusableView: UICollectionReusableView {
    static let identifier = "FooterSpinnerCollectionReusableView"
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        spinner.startAnimating()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        addSubview(spinner)
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.heightAnchor.constraint(equalToConstant: 56),
            spinner.widthAnchor.constraint(equalToConstant: 56),
        ])
    }
}
