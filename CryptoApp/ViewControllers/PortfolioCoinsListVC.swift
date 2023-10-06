//
//  PortfolioCoinsVC.swift
//  CryptoApp
//
//  Created by Alpay Calalli on 02.10.23.
//

import UIKit

final class PortfolioCoinsListVC: UIViewController {
    
    private var portfolioCoins: [Coin] = [] // PortfolioCoins
    
    private var allCoins: [Coin] = [] // AllCoins
    private var dataService = PortfolioDataService() // PortfolioEntities
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        layoutUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCoins()
    }
    
    private func getCoins() {
        Task {
            allCoins = await NetworkManager.shared.getCoins()
            portfolioCoins = mapAllCoinsToPortolioCoins(allCoins: allCoins, portfolioEntities: dataService.portfolioCoins)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
            }
        }
    }
    
    private func mapAllCoinsToPortolioCoins(allCoins: [Coin], portfolioEntities: [PortfolioEntity]) -> [Coin] {
        allCoins
            .compactMap { coin -> Coin? in
                guard let entity = portfolioEntities.first(where: { $0.id == coin.id }) else { return nil }
                return coin.updateHoldings(with: entity.amount)
        }
    }
    
    private func configure() {
        tableView.rowHeight = 60
//        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CoinItemCell.self, forCellReuseIdentifier: CoinItemCell.reuseId)
    }

    private func layoutUI() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PortfolioCoinsListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        portfolioCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoinItemCell.reuseId) as! CoinItemCell
        let coin = portfolioCoins[indexPath.row]
        cell.set(coin: coin)
        
        return cell
    }
}
