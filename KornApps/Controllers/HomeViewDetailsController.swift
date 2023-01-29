//
//  HomeViewDetailsController.swift
//  KornApps
//
//  Created by owner on 23/01/2023.
//

import UIKit

class HomeViewDetailsController: UIViewController {

    private var homeDetailsView: HomeDetailsView?
    
    private var scrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private var screenValue: UIScreen?
    private let viewModel: HomeDetailsViewViewModel
    
    init(screenValue: UIScreen?, viewModel: HomeDetailsViewViewModel) {
        self.screenValue = screenValue
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
        
        guard let screenValue = self.screenValue else {
            return
        }
        
        homeDetailsView = HomeDetailsView(frame: .zero, screenHeight: screenValue.bounds.size.height, viewModel: viewModel)
    }
    
    private func setupConstraints() {
        
        guard let homeDetailsView = homeDetailsView else {
            return
        }
        
        view.addSubview(scrollView)
        scrollView.addSubview(homeDetailsView)
        
        NSLayoutConstraint.activate([
            
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            homeDetailsView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            homeDetailsView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            homeDetailsView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            homeDetailsView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }
}
