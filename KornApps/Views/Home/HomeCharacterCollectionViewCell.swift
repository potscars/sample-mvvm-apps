//
//  HomeCharacterCollectionViewCell.swift
//  KornApps
//
//  Created by owner on 21/01/2023.
//

import UIKit
import SDWebImage

class HomeCharacterCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HomeCharacterCollectionViewCell"
    
    // MARK: - UIs
    
    private var holderView: CorneredView = {
        let v = CorneredView(5, enableShadow: true)
        v.backgroundColor = .white
        return v
    }()
    
    private var featuredImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "red_panda_one")
        return iv
    }()
    
    private var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private var subtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitital()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupInitital() {
        contentView.addSubview(holderView)
        holderView.addSubviews(featuredImageView, title, subtitle)
        
        featuredImageView.clipsToBounds = true
        featuredImageView.layer.cornerRadius = 5
        featuredImageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    private func setupContraints() {
        
        NSLayoutConstraint.activate([
        
            holderView.topAnchor.constraint(equalTo: contentView.topAnchor),
            holderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            holderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            holderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            featuredImageView.topAnchor.constraint(equalTo: holderView.topAnchor),
            featuredImageView.bottomAnchor.constraint(equalTo: title.topAnchor),
            featuredImageView.leadingAnchor.constraint(equalTo: holderView.leadingAnchor),
            featuredImageView.trailingAnchor.constraint(equalTo: holderView.trailingAnchor),
            
            title.bottomAnchor.constraint(equalTo: subtitle.topAnchor, constant: -2),
            title.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: holderView.trailingAnchor, constant: -8),
            title.heightAnchor.constraint(equalToConstant: 28),
            
            subtitle.bottomAnchor.constraint(equalTo: holderView.bottomAnchor, constant: -2),
            subtitle.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 8),
            subtitle.trailingAnchor.constraint(equalTo: holderView.trailingAnchor, constant: -8),
            subtitle.heightAnchor.constraint(equalToConstant: 28),
        ])
    }
    
    public func updateUI(with viewModel: HomeCharacterCellViewModel) {
        title.text = viewModel.name
        subtitle.text = viewModel.characterStatus
        
        guard let url = URL(string: viewModel.imageString) else {
            return
        }
        
        featuredImageView.sd_setImage(with: url)
    }
}
