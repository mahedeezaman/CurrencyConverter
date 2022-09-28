//
//  HomeViewController.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 26/09/2022.
//

import UIKit

class HomeViewController: UIViewController {
    @Published var dummyData = [
        "EUR" : "1000.0",
        "USD" : "0.0",
        "JPY" : "0.0"
    ]
    
    let balanceViewController : AvailableBalanceViewController = {
        let balanceViewController = AvailableBalanceViewController()
        balanceViewController.view.backgroundColor = ColorConstants.homeViewBackground
        return balanceViewController
    }()
    
    let buttonViewController : ButtonViewController = {
        let balanceViewController = ButtonViewController()
        //balanceViewController.view.backgroundColor = ColorConstants.homeViewBackground
        return balanceViewController
    }()
    
    @IBOutlet weak var topLabelViewContainer: UIView!
    @IBOutlet weak var segmentedControlViewContainer: UIView!
    @IBOutlet weak var mainContainerView: UIView!
    
    @IBOutlet weak var segmentedControlOutlet: UISegmentedControl!
    @IBOutlet weak var homeViewTopLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColor()
        setupMainConainterView()
        segmentedControlOutlet.setupSegmentedControl()
        
        mainContainerView.bringSubviewToFront(balanceViewController.view)
    }
    
    func setupColor() {
        view.backgroundColor = ColorConstants.homeViewBackground
        segmentedControlViewContainer.backgroundColor = ColorConstants.homeViewBackground
        topLabelViewContainer.backgroundColor = ColorConstants.homeViewContainersColor
        mainContainerView.backgroundColor = ColorConstants.homeViewContainersColor
        homeViewTopLabel.textColor = ColorConstants.homeViewTextColors
    }
    
    func setupMainConainterView() {
        mainContainerView.layer.cornerRadius = Constants.cornerRadius
        mainContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        balanceViewController.dummyData = dummyData
        addChild(balanceViewController)
        mainContainerView.addSubview(balanceViewController.view)
        balanceViewController.didMove(toParent: self)
        
        buttonViewController.delegate = self
        addChild(buttonViewController)
        mainContainerView.addSubview(buttonViewController.view)
        buttonViewController.didMove(toParent: self)
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mainContainerView.bringSubviewToFront(balanceViewController.view)
        case 1:
            mainContainerView.bringSubviewToFront(buttonViewController.view)
        default:
            mainContainerView.bringSubviewToFront(balanceViewController.view)
        }
    }
}

extension HomeViewController : ConvertedValue {
    func valueChanged(of currency: String, amount: String) {
        dummyData[currency] = amount
        balanceViewController.dummyData[currency] = amount
        balanceViewController.balanceTableView.reloadData()
    }
}

class ButtonViewController: UIViewController {
    weak var delegate : ConvertedValue? = nil
    
    override func viewDidLoad() {
        view.backgroundColor = ColorConstants.homeViewContainersColor
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let button = UIButton(frame: CGRect(x: view.frame.width/2-50, y: view.frame.height/2-100, width: 100, height: 50))
        button.backgroundColor = .green
        button.setTitle("Test Button", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func buttonAction() {
        delegate?.valueChanged(of: "EUR", amount: "Value changed")
    }
}
