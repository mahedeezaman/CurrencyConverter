//
//  ConvertCurrencyViewController.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 29/09/2022.
//

import UIKit

protocol AmountEntered: AnyObject {
    func typedAmount(amount: String)
}

class ConvertCurrencyViewController: UIViewController {
    var buyAmountVar = ""
    var sellAmountVar = "" {
        didSet {
            let numberOnlyFilter = sellAmountVar.filter { $0.isNumber || $0 == "." }
            if sellAmountVar != numberOnlyFilter {
                DispatchQueue.main.async {
                    self.sellAmountVar = numberOnlyFilter
                    self.amountEnteredDelegate?.typedAmount(amount: self.sellAmountVar)
                }
            }
            
            if Double(sellAmountVar) ?? 0 > 9999999 {
                DispatchQueue.main.async {
                    self.sellAmountVar = oldValue
                    self.amountEnteredDelegate?.typedAmount(amount: self.sellAmountVar)
                }
            }
            
            if let dotIndexFirst = sellAmountVar.firstIndex(of: "."), let dotIndexLast = sellAmountVar.lastIndex(of: ".") {
                if sellAmountVar.distance(from: dotIndexFirst, to: sellAmountVar.endIndex) - 1 > 2 {
                    DispatchQueue.main.async {
                        self.sellAmountVar = oldValue
                        self.amountEnteredDelegate?.typedAmount(amount: self.sellAmountVar)
                    }
                }
                
                if dotIndexFirst != dotIndexLast {
                    DispatchQueue.main.async {
                        self.sellAmountVar = oldValue
                        self.amountEnteredDelegate?.typedAmount(amount: self.sellAmountVar)
                    }
                }
            }
        }
    }
    var buyCurrency = ""
    var sellCurrency = ""
    weak var amountEnteredDelegate: AmountEntered?
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.backgroundColor = ColorConstants.homeViewContainersColor
        containerView.layer.cornerRadius = Constants.cornerRadius
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        submitButton.backgroundColor = ColorConstants.homeViewBackground
        submitButton.layer.cornerRadius = Constants.cornerRadius
    }
    
    func showAlertWith(title: String, and message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel))
        alertController.setBackgroundColor(color: ColorConstants.homeViewBackground)
        alertController.setTitleFontAndColor()
        alertController.setMessageFontAndColor()
        alertController.setTint()
        
        return alertController
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        let alertController = showAlertWith(title: Constants.success, and: "You have successfully created a dummy alert")
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func dialpadAdded(_ sender: UIButton) {
        if sellCurrency.isEmpty {
            let alertController = showAlertWith(title: Constants.error, and: "Please select a currency to convert from")
            self.present(alertController, animated: true, completion: nil)
        } else if buyCurrency.isEmpty {
            let alertController = showAlertWith(title: Constants.error, and: "Please select a currency to convert to")
            self.present(alertController, animated: true, completion: nil)
        } else {
            sellAmountVar += sender.titleLabel?.text ?? ""
            self.amountEnteredDelegate?.typedAmount(amount: self.sellAmountVar)
        }
    }
    
    @IBAction func dialpadDeleted(_ sender: UIButton) {
        if sellAmountVar.count > 0 {
            sellAmountVar.removeLast()
            self.amountEnteredDelegate?.typedAmount(amount: self.sellAmountVar)
        }
    }
}
