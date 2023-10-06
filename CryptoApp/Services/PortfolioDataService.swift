//
//  PortfolioDataService.swift
//  CryptoApp
//
//  Created by Alpay Calalli on 05.10.23.
//

import CoreData
import Foundation

final class PortfolioDataService {
    var portfolioCoins: [PortfolioEntity] = []
    
    private let entityName = "PortfolioEntity"
    private let containerName = "PortfolioContainer"
    private let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { ( description, error ) in
            guard error == nil else {
                return
            }
        }
        getAllCoins()
    }
    
    // MARK: Public methods
    
    func updatePortolio(coin: Coin, amount: Double) {
        if let entity = portfolioCoins.first(where: { $0.id == coin.id } ) {
            if amount > 0 {
                update(coin: entity, amount: amount)
            } else {
                delete(coin: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    // MARK: Private methods
    
    private func add(coin: Coin, amount: Double) {
        let newCoin = PortfolioEntity(context: container.viewContext)
        newCoin.id = coin.id
        newCoin.amount = amount
        applyChanges()
    }
    
    private func update(coin: PortfolioEntity, amount: Double) {
        coin.amount = amount
        applyChanges()
    }
    
    private func delete(coin: PortfolioEntity) {
        container.viewContext.delete(coin)
        applyChanges()
    }
    
    private func applyChanges() {
        save()
        getAllCoins()
    }
    
    private func getAllCoins() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            portfolioCoins = try container.viewContext.fetch(request)
        } catch {
            print("Error while fetching from CoreData", error)
        }
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error while saving to CoreData:", error)
        }
    }
}
