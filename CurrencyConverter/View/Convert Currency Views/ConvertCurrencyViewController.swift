//
//  ConvertCurrencyViewController.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 29/09/2022.
//

import UIKit

class ConvertCurrencyViewController: UIViewController {
    var buyAmountVar = ""
    var sellAmountVar = "" {
        didSet {
            let numberOnlyFilter = sellAmountVar.filter { $0.isNumber || $0 == "." }
            if sellAmountVar != numberOnlyFilter {
                DispatchQueue.main.async {
                    self.sellAmountVar = numberOnlyFilter
                    self.sellAmount.text = self.sellAmountVar
                }
            }
            
            if Double(sellAmountVar) ?? 0 > 9999999 {
                DispatchQueue.main.async {
                    self.sellAmountVar = oldValue
                    self.sellAmount.text = self.sellAmountVar
                }
            }
            
            if let dotIndexFirst = sellAmountVar.firstIndex(of: "."), let dotIndexLast = sellAmountVar.lastIndex(of: ".") {
                if sellAmountVar.distance(from: dotIndexFirst, to: sellAmountVar.endIndex) - 1 > 2 {
                    DispatchQueue.main.async {
                        self.sellAmountVar = oldValue
                        self.sellAmount.text = self.sellAmountVar
                    }
                }
                
                if dotIndexFirst != dotIndexLast {
                    DispatchQueue.main.async {
                        self.sellAmountVar = oldValue
                        self.sellAmount.text = self.sellAmountVar
                    }
                }
            }
        }
    }
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet weak var sellAmount: UILabel!
    @IBOutlet weak var sellAmountContainer: UIView!
    @IBOutlet weak var sellIcon: UIImageView!
    @IBOutlet weak var sellCurrency: UIButton!
    
    @IBOutlet weak var buyAmount: UILabel!
    @IBOutlet weak var buyAmountContainer: UIView!
    @IBOutlet weak var buyIcon: UIImageView!
    @IBOutlet weak var buyCurrency: UIButton!
    
    @IBOutlet weak var sellCurrencyChangeButton: UIButton!
    @IBOutlet weak var buyCurrencyChangeButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.backgroundColor = ColorConstants.homeViewContainersColor
        containerView.layer.cornerRadius = Constants.cornerRadius
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        sellAmount.text = sellAmountVar
        buyAmount.text = buyAmountVar
        setupBorders()
    }
    
    func setupBorders() {
        sellAmountContainer.layer.borderColor = ColorConstants.homeViewBackground.cgColor
        sellAmountContainer.layer.borderWidth = 2
        sellAmountContainer.layer.cornerRadius = Constants.cornerRadius
        
        buyAmountContainer.layer.borderColor = ColorConstants.homeViewBackground.cgColor
        buyAmountContainer.layer.borderWidth = 2
        buyAmountContainer.layer.cornerRadius = Constants.cornerRadius
        
        sellCurrencyChangeButton.layer.borderColor = ColorConstants.homeViewBackground.cgColor
        sellCurrencyChangeButton.layer.borderWidth = 2
        sellCurrencyChangeButton.layer.cornerRadius = Constants.cornerRadius
        
        buyCurrencyChangeButton.layer.borderColor = ColorConstants.homeViewBackground.cgColor
        buyCurrencyChangeButton.layer.borderWidth = 2
        buyCurrencyChangeButton.layer.cornerRadius = Constants.cornerRadius
        
        submitButton.backgroundColor = ColorConstants.homeViewBackground
        submitButton.layer.cornerRadius = Constants.cornerRadius
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func sellcurrencyTapped(_ sender: UIButton) {
    }
    
    @IBAction func buyCurrencyTapped(_ sender: UIButton) {
    }
    
    @IBAction func dialpadAdded(_ sender: UIButton) {
        sellAmountVar += sender.titleLabel?.text ?? ""
        sellAmount.text = sellAmountVar
    }
    
    @IBAction func dialpadDeleted(_ sender: UIButton) {
        if sellAmountVar.count > 0 {
            sellAmountVar.removeLast()
            sellAmount.text = sellAmountVar
        }
    }
}
