//
//  BreedItemRepository.swift
//  Cat Refactor
//
//  Created by Yu on 2022/2/19.
//

import Foundation

internal protocol BreedItemsRepositoryProtocal{
    func breedItems() -> [Breed]
}

class BreedItemsRepository: BreedItemsRepositoryProtocal {
    func breedItems() -> [Breed] {
        // do something ...
        
        return [Breed]()
    }
}
