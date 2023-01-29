//
//  HomeViewController.swift
//  KornApps
//
//  Created by owner on 19/01/2023.
//

import UIKit

class HomeViewController: UIViewController {

    private var homeView: HomeView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitial()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupInitial() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Sample Apps"
        view.backgroundColor = .white
        
        homeView = HomeView(viewController: self)
        homeView?.delegate = self
    }
    
    private func setupConstraints() {
        
        guard let homeView = homeView else { return }
        
        view.addSubview(homeView)
        
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            homeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension HomeViewController: HomeViewDelegate {
    func didSelect(for character: RMCharacter) {
        let homeDetailVM = HomeDetailsViewViewModel(character)
        let homeDetailsVC = HomeViewDetailsController(screenValue: screen(), viewModel: homeDetailVM)
        navigationController?.pushViewController(homeDetailsVC, animated: true)
    }
}
