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
    var availableBalance = "0.0"
    var currencyData = CurrencyDataModel() {
        didSet {
            let numberOnlyFilter = currencyData.fromAmount.filter { $0.isNumber || $0 == "." }
            if currencyData.fromAmount != numberOnlyFilter {
                DispatchQueue.main.async {
                    self.currencyData.fromAmount = numberOnlyFilter
                    self.amountEnteredDelegate?.typedAmount(amount: self.currencyData.fromAmount)
                }
            }
            
            if Double(currencyData.fromAmount) ?? 0 > 9999999 {
                DispatchQueue.main.async {
                    self.currencyData.fromAmount = oldValue.fromAmount
                    self.amountEnteredDelegate?.typedAmount(amount: self.currencyData.fromAmount)
                }
            }
            
            if let dotIndexFirst = currencyData.fromAmount.firstIndex(of: "."), let dotIndexLast = currencyData.fromAmount.lastIndex(of: ".") {
                if currencyData.fromAmount.distance(from: dotIndexFirst, to: currencyData.fromAmount.endIndex) - 1 > 2 {
                    DispatchQueue.main.async {
                        self.currencyData.fromAmount = oldValue.fromAmount
                        self.amountEnteredDelegate?.typedAmount(amount: self.currencyData.fromAmount)
                    }
                }
                
                if dotIndexFirst != dotIndexLast {
                    DispatchQueue.main.async {
                        self.currencyData.fromAmount = oldValue.fromAmount
                        self.amountEnteredDelegate?.typedAmount(amount: self.currencyData.fromAmount)
                    }
                }
            }
            
            if StringUtilities.convertStringToDouble(data: currencyData.fromAmount) > StringUtilities.convertStringToDouble(data: availableBalance) {
                DispatchQueue.main.async {
                    self.currencyData.fromAmount = oldValue.fromAmount
                    self.amountEnteredDelegate?.typedAmount(amount: self.currencyData.fromAmount)
                    let alertController = self.showAlertWith(title: AlertConstants.error, and: AlertConstants.insufficientBalance)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
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
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        guard StringUtilities.convertStringToDouble(data: currencyData.fromAmount) > 0.0 else {
            let alertController = showAlertWith(title: AlertConstants.success, and: AlertConstants.amountCantBeZero)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        self.amountEnteredDelegate?.typedAmount(amount: AlertConstants.submit)
    }
    
    
    @IBAction func dialpadAdded(_ sender: UIButton) {
        guard !currencyData.fromCurrency.isEmpty else {
            let alertController = showAlertWith(title: AlertConstants.error, and: AlertConstants.selectToConvertFrom)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        guard !currencyData.toCurrency.isEmpty else {
            let alertController = showAlertWith(title: AlertConstants.error, and: AlertConstants.selectToConvertTo)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        currencyData.fromAmount += sender.titleLabel?.text ?? ""
        self.amountEnteredDelegate?.typedAmount(amount: currencyData.fromAmount)
    }
    
    @IBAction func dialpadDeleted(_ sender: UIButton) {
        if currencyData.fromAmount.count > 0 {
            currencyData.fromAmount.removeLast()
            self.amountEnteredDelegate?.typedAmount(amount: self.currencyData.fromAmount)
        }
    }
}
