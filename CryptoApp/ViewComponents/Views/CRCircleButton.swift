//
//  CRCircleButton.swift
//  CryptoApp
//
//  Created by Alpay Calalli on 30.09.23.
//

import UIKit

class CRCircleButton: UIImageView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(iconName: String) {
        self.init(frame: .zero)
        image = UIImage(systemName: iconName)
        
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
    }
    
}
