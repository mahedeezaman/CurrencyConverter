//
//  HomeViewController.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 26/09/2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeViewTopLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = ColorConstants.homeViewBackground
        
        homeViewTopLabel.textColor = ColorConstants.homeViewContainersColor
        homeViewTopLabel.layer.cornerRadius = Constants.cornerRadius
        homeViewTopLabel.layer.borderColor = ColorConstants.homeViewContainersColor.cgColor
        homeViewTopLabel.layer.borderWidth = 5
    }
}
