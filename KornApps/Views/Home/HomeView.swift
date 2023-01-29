//
//  HomeView.swift
//  KornApps
//
//  Created by owner on 19/01/2023.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func didSelect(for character: RMCharacter)
}

class HomeView: UIView {
    
    private let viewModel = HomeViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        cv.backgroundColor = .clear
        cv.register(HomeCharacterCollectionViewCell.self, forCellWithReuseIdentifier: HomeCharacterCollectionViewCell.identifier)
        cv.register(FooterSpinnerCollectionReusableView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                    withReuseIdentifier: FooterSpinnerCollectionReusableView.identifier)
        
        return cv
    }()
    
    private var menuInteraction: UIContextMenuInteraction?
    private var screenValue: UIScreen?
    private var viewController: UIViewController
    weak var delegate: HomeViewDelegate?
    
    // MARK: - Init
    
    init(viewController: UIViewController) {
        
        self.viewController = viewController
        self.screenValue = viewController.screen()
        
        super.init(frame: .zero)
        
        self.setupInitial()
        self.setupConstraints()
        viewModel.getCharacters()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupInitial() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        //        menuInteraction = UIContextMenuInteraction(delegate: self)
        viewModel.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.isHidden = true
        spinner.isHidden = false
        spinner.startAnimating()
        
        addSubviews(spinner, collectionView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.heightAnchor.constraint(equalToConstant: 56),
            spinner.widthAnchor.constraint(equalToConstant: 56),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension HomeView: UICollectionViewDelegate,
                    UICollectionViewDataSource,
                    UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.characterViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCharacterCollectionViewCell.identifier, for: indexPath) as? HomeCharacterCollectionViewCell else {
            fatalError()
        }
        
        cell.updateUI(with: viewModel.characterViewModels[indexPath.row])

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = (collectionView.bounds.width-30)/2
        let height: CGFloat = width * 1.3
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelect(for: viewModel.selectCharacter(for: indexPath.item))
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: FooterSpinnerCollectionReusableView.identifier,
                                                                         for: indexPath)
            
            return footer
        } else {
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if let charInfo = viewModel.charactersInfo {
            if let _ = charInfo.next {
                return CGSize(width: collectionView.bounds.width, height: 56)
            }
        }
        
        return .zero
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let charInfo = viewModel.charactersInfo {
            if let nextPage = charInfo.next, !viewModel.isLoadingMoreCharacters {
                
                Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] timer in
                    
                    guard let self = self else { return }
                    
                    let offset = scrollView.contentOffset.y
                    let totalContentHeight = scrollView.contentSize.height
                    let totalScrollViewFixedHeight = scrollView.frame.size.height
                    
                    if offset >= (totalContentHeight - totalScrollViewFixedHeight - 150) {
                        self.viewModel.getMoreCharacters(with: nextPage)
                    }
                    
                    timer.invalidate()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        
        guard let indexPath = collectionView.indexPathForItem(at: point) else {
            return nil
        }
        
        let homeDetailsPreview = { [weak self] in
            
            guard let self = self else {
                return UIViewController()
            }
            
            let detailViewModel = HomeDetailsViewViewModel(self.viewModel.selectCharacter(for: indexPath.row))
            let peekVC = HomeDetailPreviewViewController(viewModel: detailViewModel)
            return peekVC
        }
        
        return UIContextMenuConfiguration(previewProvider: homeDetailsPreview) { _ -> UIMenu? in
            let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.shareCharacter(viewController: self.viewController)
            }
            
            return UIMenu(title: "Menu", children: [shareAction])
        }
    }
}

extension HomeView: HomeViewViewModelDelegate {
    func didLoadFirstCharactersData() {
        
        collectionView.isHidden = false
        spinner.isHidden = true
        
        collectionView.reloadData()
    }
    
    func didLoadMoreCharacters(with newIndexPath: [IndexPath]) {
        collectionView.performBatchUpdates { [weak self] in
            self?.collectionView.insertItems(at: newIndexPath)
        }
    }
}
