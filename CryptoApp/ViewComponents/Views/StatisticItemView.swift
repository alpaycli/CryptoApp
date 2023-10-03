//
//  StatisticItemView.swift
//  CryptoApp
//
//  Created by Alpay Calalli on 03.10.23.
//

import UIKit

class StatisticItemView: UIView {
    
    private let stackView = UIStackView()
    private let secondaryTitleLabel = GFSecondaryTitleLabel(fontSize: 14)
    private let priceLabel = GFTitleLabel(textAlignment: .left, fontSize: 16)
    private let valueChange = GFSecondaryTitleLabel(fontSize: 14)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStackView()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        stackView.addArrangedSubview(secondaryTitleLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(valueChange)
    }
    
    func set(title: String, priceLabel: String, valueChange: Double? = nil) {
        self.secondaryTitleLabel.text = title
        self.priceLabel.text = priceLabel
        self.valueChange.text = valueChange?.asPercentString()
        
        self.priceLabel.textColor = UIColor.theme.accentColor
        self.valueChange.textColor = valueChange ?? 0 > 0 ? UIColor.theme.greenColor : UIColor.theme.redColor
    }
    
    private func configure() {
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
