//
//  CoinItemCell.swift
//  CryptoApp
//
//  Created by Alpay Calalli on 01.10.23.
//

import UIKit

class CoinItemCell: UITableViewCell {

    static let reuseId = "CoinItemCell"
    let rank = GFSecondaryTitleLabel(fontSize: 14)
    let avatarImage = GFAvatarImageView(frame: .zero)
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 20)
    
    let currentPriceLabel = GFTitleLabel(textAlignment: .right, fontSize: 16)
    let priceChangeLabel = GFSecondaryTitleLabel(fontSize: 16)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(coin: Coin) {
        rank.text = "\(coin.rank)"
        Task { await avatarImage.downloadImage(fromURL: coin.image) }
        titleLabel.text = coin.symbol.uppercased()
        
        currentPriceLabel.text = coin.currentPrice.asCurrencyWith6Decimals()
        priceChangeLabel.text = coin.priceChangePercentage24H?.asPercentString()
        priceChangeLabel.textColor = coin.priceChangePercentage24H ?? 0 > 0 ?
        UIColor.theme.greenColor : UIColor.theme.redColor
    }
    
    private func configure() {
        addSubview(rank)
        addSubview(avatarImage)
        addSubview(titleLabel)
        addSubview(currentPriceLabel)
        addSubview(priceChangeLabel)
        
        let padding: CGFloat = 12
        
        accessoryType = .none
        
        NSLayoutConstraint.activate([
            rank.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rank.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            rank.heightAnchor.constraint(equalToConstant: 50),
            
            avatarImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImage.leadingAnchor.constraint(equalTo: rank.trailingAnchor, constant: padding),
            avatarImage.widthAnchor.constraint(equalToConstant: 40),
            avatarImage.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            currentPriceLabel.topAnchor.constraint(equalTo: self.topAnchor),
            currentPriceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            currentPriceLabel.heightAnchor.constraint(equalToConstant: 25),
            
            priceChangeLabel.topAnchor.constraint(equalTo: currentPriceLabel.bottomAnchor),
            priceChangeLabel.trailingAnchor.constraint(equalTo: currentPriceLabel.trailingAnchor),
            priceChangeLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }

}
