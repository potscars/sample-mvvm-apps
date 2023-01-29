//
//  HomeCharacterCellViewModel.swift
//  KornApps
//
//  Created by owner on 25/01/2023.
//

import Foundation

class HomeCharacterCellViewModel: Hashable, Equatable {
    
    var name: String
    var status: RMCharacter.RMStatus
    var imageString: String
    
    init(name: String, status: RMCharacter.RMStatus, imageString: String) {
        self.name = name
        self.status = status
        self.imageString = imageString
    }
    
    // combine the hash to make an unique identifier for the object
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(status)
        hasher.combine(imageString)
    }
    
    static func == (lhs: HomeCharacterCellViewModel, rhs: HomeCharacterCellViewModel) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    public var characterStatus: String {
        status.rawValue.capitalized
    }
}
