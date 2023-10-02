//
//  HomeVC.swift
//  CryptoApp
//
//  Created by Alpay Calalli on 30.09.23.
//

import UIKit

final class HomeVC: UIViewController {
    
    var showPortolio = false
    
    private let allCoinsListView = UIView()
    private let portfolioCoinsListView = UIView()
    
    private let allCoinsListVC = CoinsListVC()
    private let portfolioCoinsListVC = PortfolioCoinsListVC()
    
    private let navbarStackView = UIStackView()
    private let navLeadingButton = CRCircleButton(iconName: "info")
    private let navbarText = GFTitleLabel(textAlignment: .center, fontSize: 18)
    private let navTrailingButton = CRCircleButton(iconName: "arrow.right")
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        setupViewControllers()
        configureStackView()
        layoutUI()
        
        allCoinsListView.frame.origin.x = self.view.frame.width
        portfolioCoinsListView.frame.origin.x = 0
    }
    
    private func configureStackView() {
        navbarStackView.axis = .horizontal
        navbarStackView.distribution = .equalSpacing
        
        navbarText.text = "Live Prices"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(rightArrowTap(_:)))
        navTrailingButton.isUserInteractionEnabled = true
        navTrailingButton.addGestureRecognizer(tap)
        
        NSLayoutConstraint.activate([
            navLeadingButton.widthAnchor.constraint(equalToConstant: 40),
            navLeadingButton.heightAnchor.constraint(equalToConstant: 40),
            
            navTrailingButton.widthAnchor.constraint(equalToConstant: 40),
            navTrailingButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        navbarStackView.addArrangedSubview(navLeadingButton)
        navbarStackView.addArrangedSubview(navbarText)
        navbarStackView.addArrangedSubview(navTrailingButton)
    }
    
    @objc func rightArrowTap(_ sender: UITapGestureRecognizer? = nil) {
        if showPortolio { showPortolio = false } else { showPortolio = true }
        UIView.animate(withDuration: 0.5) {
            self.navTrailingButton.transform = self.showPortolio ? CGAffineTransform(rotationAngle: .pi) : CGAffineTransform.identity
        }
        toggleView()
    }
    
    private func setupViewControllers() {
        self.add(childVC: portfolioCoinsListVC, to: portfolioCoinsListView)
        self.add(childVC: allCoinsListVC, to: allCoinsListView)
    }
    
    private func layoutUI() {
        view.addSubview(navbarStackView)
        view.addSubview(portfolioCoinsListView)
        view.addSubview(allCoinsListView)
        
        navbarStackView.translatesAutoresizingMaskIntoConstraints = false
        portfolioCoinsListView.translatesAutoresizingMaskIntoConstraints = false
        allCoinsListView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            navbarStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            navbarStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            navbarStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            navbarStackView.heightAnchor.constraint(equalToConstant: 40),
            
            portfolioCoinsListView.topAnchor.constraint(equalTo: navbarStackView.bottomAnchor, constant: 40),
            portfolioCoinsListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            portfolioCoinsListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            portfolioCoinsListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            allCoinsListView.topAnchor.constraint(equalTo: navbarStackView.bottomAnchor, constant: 40),
            allCoinsListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            allCoinsListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            allCoinsListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    func toggleView() {
        if showPortolio {
            UIView.animate(withDuration: 0.5) {
                self.allCoinsListView.frame.origin.x = -self.view.frame.width
                self.portfolioCoinsListView.frame.origin.x = 0
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.portfolioCoinsListView.frame.origin.x = self.view.frame.width
                self.allCoinsListView.frame.origin.x = 0
            }
        }
    }
    
}
