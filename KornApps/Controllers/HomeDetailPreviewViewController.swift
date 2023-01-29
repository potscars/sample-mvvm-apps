//
//  HomeDetailPreviewViewController.swift
//  KornApps
//
//  Created by owner on 28/01/2023.
//

import UIKit

class HomeDetailPreviewViewController: UIViewController {

    private var homePreviewView: HomeDetailPreviewView?
    private let viewModel: HomeDetailsViewViewModel
    
    init(viewModel: HomeDetailsViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitial()
        setupConstraints()
    }
    
    private func setupInitial() {
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .white
        
        homePreviewView = HomeDetailPreviewView(viewModel: viewModel)
    }
    
    private func setupConstraints() {
        
        guard let homePreviewView = homePreviewView else {
            return
        }
        
        view.addSubview(homePreviewView)
        
        NSLayoutConstraint.activate([
            
            homePreviewView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            homePreviewView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homePreviewView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            homePreviewView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
}
