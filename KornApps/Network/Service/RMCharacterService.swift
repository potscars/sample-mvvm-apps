//
//  RMCharacterService.swift
//  KornApps
//
//  Created by owner on 24/01/2023.
//

import Foundation

class RMCharacterService {
    static let shared = RMCharacterService()
    
    private init() { }
    
    func getCharacters(paramsString: String? = nil, completion: @escaping (Result<RMCharactersResponse, Error>) -> ()) {
        let router = Router<RMCharacterEndpoint>()
        
        router.request(.characters(params: paramsString),
                       expecting: RMCharactersResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
