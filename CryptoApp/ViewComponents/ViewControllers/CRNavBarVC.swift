//
//  CRNavBarVC.swift
//  CryptoApp
//
//  Created by Alpay Calalli on 30.09.23.
//

import UIKit

class CRNavBarVC: UIViewController {
    
    private let circleButton = CRCircleButton(iconName: "person.2")
    private let navbarText = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure()
        // Do any additional setup after loading the view.
    }
    
    private func configure() {
        view.addSubview(circleButton)
        view.addSubview(navbarText)
        
        NSLayoutConstraint.activate([
            circleButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            circleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circleButton.widthAnchor.constraint(equalToConstant: 60),
            circleButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
