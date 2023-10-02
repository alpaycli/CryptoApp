//
//  GFAvatarImageView.swift
//  CryptoApp
//
//  Created by Alpay Calalli on 01.10.23.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeholderImage = UIImage(systemName: "person")
    
    // MARK: Bad coding approach, will handle this
    private let cache = NetworkManager.shared.cache

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(fromURL url: String) async {
        let returnedImage = await NetworkManager.shared.downloadImage(urlString: url)
        image = returnedImage
    }
    
}

