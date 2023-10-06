//
//  HomeVC.swift
//  CryptoApp
//
//  Created by Alpay Calalli on 30.09.23.
//

import UIKit

final class HomeVC: UIViewController {
    
    private var showPortolio = false
    
    private let navbarStackView = UIStackView()
    private let navLeadingButton = CRCircleButton(iconName: "info")
    private let navbarText = GFTitleLabel(textAlignment: .center, fontSize: 18)
    private let navTrailingButton = CRCircleButton(iconName: "arrow.right")
    
    private let statisticsView = UIView()
    
    private let columnFirstTitle = GFSecondaryTitleLabel(fontSize: 14)
    private let columnSecondTitle = GFSecondaryTitleLabel(fontSize: 14)
    private let columnThirdTitle = GFSecondaryTitleLabel(fontSize: 14)
    
    private let allCoinsListView = UIView()
    private let portfolioCoinsListView = UIView()
    
    private var statisticsVC: StatisticsVC
    private let allCoinsListVC = CoinsListVC()
    private let portfolioCoinsListVC = PortfolioCoinsListVC()
        
    init() {
        statisticsVC = StatisticsVC(portfolioCoins: [])
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        setupViewControllers()
        configureNavbarStackView()
        layoutUI()
        
        allCoinsListView.frame.origin.x = self.view.frame.width
        portfolioCoinsListView.frame.origin.x = -self.view.frame.width
    }
    
    private func configureNavbarStackView() {
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
    
    @objc private func rightArrowTap(_ sender: UITapGestureRecognizer? = nil) {
        showPortolio.toggle()
        UIView.animate(withDuration: 0.5) {
            self.navTrailingButton.transform = self.showPortolio ? CGAffineTransform(rotationAngle: .pi) : CGAffineTransform.identity
            self.statisticsVC.stackView.frame.origin.x = self.showPortolio ? -100 : 15
        }
        toggleView()
    }
    
    private func layoutUI() {
        view.addSubview(navbarStackView)
        view.addSubview(statisticsView)
        
        view.addSubview(columnFirstTitle)
        view.addSubview(columnSecondTitle)
        view.addSubview(columnThirdTitle)
        columnFirstTitle.text = "Coin"
        columnThirdTitle.text = "Price"
        
        view.addSubview(portfolioCoinsListView)
        view.addSubview(allCoinsListView)
        
        navbarStackView.translatesAutoresizingMaskIntoConstraints = false
        statisticsView.translatesAutoresizingMaskIntoConstraints = false
        portfolioCoinsListView.translatesAutoresizingMaskIntoConstraints = false
        allCoinsListView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            navbarStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            navbarStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            navbarStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            navbarStackView.heightAnchor.constraint(equalToConstant: 40),
            
            statisticsView.topAnchor.constraint(equalTo: navbarStackView.bottomAnchor, constant: 20),
            statisticsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statisticsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statisticsView.heightAnchor.constraint(equalToConstant: 60),
            
            columnFirstTitle.topAnchor.constraint(equalTo: statisticsView.bottomAnchor, constant: 40),
            columnFirstTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            columnFirstTitle.heightAnchor.constraint(equalToConstant: 30),
            
            columnThirdTitle.topAnchor.constraint(equalTo: columnFirstTitle.topAnchor),
            columnThirdTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            columnThirdTitle.heightAnchor.constraint(equalToConstant: 40),
            
            portfolioCoinsListView.topAnchor.constraint(equalTo: columnFirstTitle.bottomAnchor, constant: 10),
            portfolioCoinsListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            portfolioCoinsListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            portfolioCoinsListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            allCoinsListView.topAnchor.constraint(equalTo: columnFirstTitle.bottomAnchor, constant: 10),
            allCoinsListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            allCoinsListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            allCoinsListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func toggleView() {
        if showPortolio {
            UIView.animate(withDuration: 0.5) {
                print("sa")
                self.allCoinsListView.frame.origin.x = -self.view.frame.width
                self.portfolioCoinsListView.frame.origin.x = 0
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                print("as")
                self.portfolioCoinsListView.frame.origin.x = self.view.frame.width
                self.allCoinsListView.frame.origin.x = 0
            }
        }
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    private func setupViewControllers() {
        self.add(childVC: portfolioCoinsListVC, to: portfolioCoinsListView)
        self.add(childVC: allCoinsListVC, to: allCoinsListView)
        self.add(childVC: statisticsVC, to: statisticsView)
    }
}
