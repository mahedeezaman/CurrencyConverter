//
//  HomeViewController.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 26/09/2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var topLabelViewContainer: UIView!
    @IBOutlet weak var segmentedControlViewContainer: UIView!
    @IBOutlet weak var mainContainerView: UIView!
    
    @IBOutlet weak var segmentedControlOutlet: UISegmentedControl!
    @IBOutlet weak var homeViewTopLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = ColorConstants.homeViewBackground
        segmentedControlViewContainer.backgroundColor = ColorConstants.homeViewBackground
        topLabelViewContainer.backgroundColor = ColorConstants.homeViewContainersColor
        mainContainerView.backgroundColor = ColorConstants.homeViewContainersColor
        
        segmentedControlOutlet.setupSegmentedControl()
        
        homeViewTopLabel.textColor = ColorConstants.homeViewTextColors
        
        mainContainerView.layer.cornerRadius = Constants.cornerRadius
        mainContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
    }
}
