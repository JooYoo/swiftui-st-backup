//
//  BreedItemsUsecase.swift
//  Cat Refactor
//
//  Created by Yu on 2022/2/19.
//

import Foundation

// FIXME: public not work
internal protocol BreedItemsUseCaseProtocal{
    func getBreedItems() async -> [Breed]
}

public class BreedItemsUseCase: BreedItemsUseCaseProtocal {
    let repo = BreedItemsRepository()
    
    func getBreedItems() async -> [Breed] {
        // do somthing...
        return [Breed]()
    }
}
