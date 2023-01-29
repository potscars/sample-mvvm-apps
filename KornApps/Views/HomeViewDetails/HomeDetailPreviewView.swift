//
//  HomeDetailPreviewView.swift
//  KornApps
//
//  Created by owner on 28/01/2023.
//

import UIKit

class HomeDetailPreviewView: UIView {

    private var contentImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.numberOfLines = 0
        return label
    }()

    private var viewModel: HomeDetailsViewViewModel
    
    init(viewModel: HomeDetailsViewViewModel) {
        
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        self.setupInitial()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupInitial() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(contentImageView, titleLabel)
        
        titleLabel.text = viewModel.characterName
        
        contentImageView.sd_setImage(with: viewModel.imageURL)
    }
    
    private let padding20: CGFloat = 20
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
            
            contentImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            contentImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
