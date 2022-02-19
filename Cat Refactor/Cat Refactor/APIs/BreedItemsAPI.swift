//
//  BreedItemsAPI.swift
//  Cat Refactor
//
//  Created by Yu on 2022/2/19.
//

import Foundation

internal protocol BreedItemsAPIProtocal{
    func breedItems() -> [Breed]
}

public class BreedItemsAPI: BreedItemsAPIProtocal {
    func breedItems() -> [Breed] {
        // do something ...
        
        return [Breed]()
    }
    
    
}
