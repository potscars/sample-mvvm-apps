//
//  HomeDetailsViewViewModel.swift
//  KornApps
//
//  Created by owner on 25/01/2023.
//

import Foundation

class HomeDetailsViewViewModel {
    
    private var character: RMCharacter
    
    init(_ character: RMCharacter) {
        self.character = character
    }
    
    var imageURL: URL? {
        
        guard let url = URL(string: character.image) else {
            return nil
        }
        
        return url
    }
    
    var characterName: String {
        self.character.name.capitalized
    }
    
    var speciesLabelString: String {
        "Species: \(self.character.species) - \(self.character.gender.rawValue)"
    }
    
    var typeLabelString: String {
        "Type: \(self.character.type == "" ? "N/A" : self.character.type)"
    }
    
    var locationLabelString: String {
        "Location: \(self.character.origin.name) - \(self.character.location.name)"
    }
    
    var statusLabelString: String {
        "Status: \(self.character.status.rawValue)"
    }
    
    var locationName: String {
        self.character.location.name
    }
    var originName: String {
        self.character.origin.name
    }
}
