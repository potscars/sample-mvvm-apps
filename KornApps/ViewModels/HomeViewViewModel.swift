//
//  HomeViewViewModel.swift
//  KornApps
//
//  Created by owner on 25/01/2023.
//

import Foundation
import UIKit

protocol HomeViewViewModelDelegate: AnyObject {
    func didLoadFirstCharactersData()
    func didLoadMoreCharacters(with newIndexPath: [IndexPath])
}

class HomeViewViewModel {
    
    weak var delegate: HomeViewViewModelDelegate?
    
    private var characters: [RMCharacter] = [] {
        didSet {
            for character in characters {
                let vm = HomeCharacterCellViewModel(name: character.name,
                                                    status: character.status,
                                                    imageString: character.image)
                
                if !characterViewModels.contains(vm) {
                    characterViewModels.append(vm)
                }
            }
        }
    }
    
    var charactersInfo: RMInfo?
    var characterViewModels: [HomeCharacterCellViewModel] = []
    var isLoadingMoreCharacters: Bool = false
    
    func getCharacters() {
        RMCharacterService.shared.getCharacters { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.characters = response.results
                self.charactersInfo = response.info
                print("NEXT URL: - ", response.info.next ?? "")
                
                DispatchQueue.main.async {
                    self.delegate?.didLoadFirstCharactersData()
                }
            case .failure(let error):
                print("Error: - \(String(describing: error))")
            }
        }
    }
    
    func getMoreCharacters(with nextPageUrlString: String) {
        
        guard !isLoadingMoreCharacters else { return }
        
        let paramComponents = nextPageUrlString.components(separatedBy: "?")
        isLoadingMoreCharacters = true
        
        RMCharacterService.shared.getCharacters(paramsString: paramComponents.last) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                
                let originalTotalCount = self.characters.count
                let moreCount = response.results.count
                let totalCount = originalTotalCount + moreCount
                
                let indexPathsToAdd: [IndexPath] = Array(originalTotalCount..<totalCount).compactMap({
                    return IndexPath(item: $0, section: 0)
                })
                
                self.characters.append(contentsOf: response.results)
                self.charactersInfo = response.info
                
                print(indexPathsToAdd.count, originalTotalCount, moreCount)
                
                DispatchQueue.main.async {
                    self.delegate?.didLoadMoreCharacters(with: indexPathsToAdd)
                    self.isLoadingMoreCharacters = false
                }
            case .failure(let error):
                self.isLoadingMoreCharacters = false
                print("Error: - \(String(describing: error))")
            }
        }
    }
    
    public func selectCharacter(for index: Int) -> RMCharacter {
        return characters[index]
    }
    
    func shareCharacter(viewController: UIViewController) {
        // Setting description
        let firstActivityItem = "Share to friends.."
        
        // Setting url
        let secondActivityItem : NSURL = NSURL(string: "http://www.google.com/")!
        
        // If you want to use an image
        let image : UIImage = UIImage(named: "red_panda_one")!
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)
        
        // This lines is for the popover you need to show in iPad
        //            activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)
        
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        // Pre-configuring activity items
        activityViewController.activityItemsConfiguration = [
            UIActivity.ActivityType.message
        ] as? UIActivityItemsConfigurationReading
        
        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToFacebook
        ]
        
        activityViewController.isModalInPresentation = true
        
        DispatchQueue.main.async {
            viewController.present(activityViewController, animated: true, completion: nil)
        }
    }
}
