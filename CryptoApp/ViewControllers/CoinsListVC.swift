//
//  CoinsListVC.swift
//  CryptoApp
//
//  Created by Alpay Calalli on 02.10.23.
//

import UIKit

final class CoinsListVC: UIViewController {
    
    private var coins: [Coin] = []
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        layoutUI()
        coins = [ Coin.example, Coin.example ]
        //Task { await getCoins() }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func getCoins() async {
        do {
            coins = await NetworkManager.shared.getCoins()
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
            }
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

extension CoinsListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoinItemCell.reuseId) as! CoinItemCell
        let coin = coins[indexPath.row]
        cell.set(coin: coin)
        
        return cell
    }
}
