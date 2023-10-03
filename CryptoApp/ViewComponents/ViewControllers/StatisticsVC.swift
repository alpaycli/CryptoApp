//
//  StatisticsVC.swift
//  CryptoApp
//
//  Created by Alpay Calalli on 03.10.23.
//

import UIKit

class StatisticsVC: UIViewController {
    
    let portfolioCoins: [Coin]
    init(portfolioCoins: [Coin]) {
        self.portfolioCoins = portfolioCoins
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var marketData: MarketData? = nil
    
    private var statistics: [Statistic] = []
    
    let stackView = UIStackView()
    
    private let marketCapStatView = StatisticItemView()
    private let totalVolumeStatView = StatisticItemView()
    private let btcDominanceStatView = StatisticItemView()
    private let portolioStatView = StatisticItemView()

    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await fetchMarketData()
            configureStackView()
        }
        layoutUI()
    }
    
    private func fetchMarketData() async {
        do {
            guard let data = await NetworkManager.shared.fetvhMarketData() else { return }
            print("data.", data)
            
            let portfolioValue = portfolioCoins
                                    .map( { $0.currentHoldingsValue } )
                                    .reduce(0, +)
            
            let previousValue = portfolioCoins
                                    .map { coin -> Double in
                                        let currentValue = coin.currentHoldingsValue
                                        let priceChangePercentage = (coin.priceChangePercentage24H ?? 0) / 100
                                        let previousValue = currentValue / (priceChangePercentage + 1)
                                        
                                        return previousValue
                                    }
                                    .reduce(0, +)
            
    //        let percentageChange = 100 - (previousValue * 100 / portfolioValue)
            let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
            
            
            let marketCap = Statistic(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
            let volume = Statistic(title: "Total Volume", value: data.volume)
            let btcDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
            let portfolio = Statistic(title: "Portolio", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)
            
            statistics.append(contentsOf: [
                marketCap,
                volume,
                btcDominance,
                portfolio
            ])
            
        }
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        print("stats", statistics)
        for stat in statistics {
            let statItemView = StatisticItemView()
            statItemView.translatesAutoresizingMaskIntoConstraints = false
            statItemView.translatesAutoresizingMaskIntoConstraints = false
            statItemView.set(title: stat.title, priceLabel: stat.value, valueChange: stat.percentageChange)
            statItemView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3).isActive = true
            stackView.addArrangedSubview(statItemView)
        }
    }
    
    private func layoutUI() {
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
        ])
       
    }
}
