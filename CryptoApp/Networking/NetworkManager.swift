//
//  NetworkManager.swift
//  CryptoApp
//
//  Created by Alpay Calalli on 01.10.23.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.coingecko.com/api/v3/"
    let cache = NSCache<NSString, UIImage>()
    
    private init() { }
    
    func getCoins() async -> [Coin] {
        let endpoint = baseURL + "coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
        
        guard let url = URL(string: endpoint) else {
            print("Bad URL")
            return []
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let coins = try JSONDecoder().decode([Coin].self, from: data)
            print("coins", coins)
            return coins
        } catch {
            print("Parsing error")
            return []
        }
    }
    
    func downloadImage(urlString: String) async -> UIImage? {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            return image
        }
        
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            return nil
        }
    }
}
