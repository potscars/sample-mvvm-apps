//
//  HomeDetailsView.swift
//  KornApps
//
//  Created by owner on 23/01/2023.
//

import UIKit
import SDWebImage

class HomeDetailsView: UIView {
    
    private var contentImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .blue
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        iv.image = UIImage(named: "red_panda_one")
        return iv
    }()
    
    private var stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 10
        return sv
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private var typeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private var statusLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private var speciesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private var locationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private var screenHeight: CGFloat
    private var viewModel: HomeDetailsViewViewModel
    
    init(frame: CGRect, screenHeight: CGFloat, viewModel: HomeDetailsViewViewModel) {
        
        self.screenHeight = screenHeight
        self.viewModel = viewModel
        
        super.init(frame: frame)
        
        self.setupInitial()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupInitial() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(contentImageView, stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(statusLabel)
        stackView.addArrangedSubview(speciesLabel)
        stackView.addArrangedSubview(typeLabel)
        stackView.addArrangedSubview(locationLabel)
        
        titleLabel.text = viewModel.characterName
        typeLabel.text = viewModel.typeLabelString
        locationLabel.text = viewModel.locationLabelString
        speciesLabel.text = viewModel.speciesLabelString
        statusLabel.text = viewModel.statusLabelString
        
        contentImageView.sd_setImage(with: viewModel.imageURL)
    }
    
    private let padding20: CGFloat = 20
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            contentImageView.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            contentImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3),
            contentImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3),
            contentImageView.heightAnchor.constraint(equalToConstant: self.screenHeight * 0.4),
            
            stackView.topAnchor.constraint(equalTo: contentImageView.bottomAnchor, constant: padding20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding20),
        ])
    }
}
