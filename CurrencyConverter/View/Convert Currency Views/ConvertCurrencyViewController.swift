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
//                    self.sellAmount.text = self.sellAmountVar
                }
            }
            
            if Double(sellAmountVar) ?? 0 > 9999999 {
                DispatchQueue.main.async {
                    self.sellAmountVar = oldValue
//                    self.sellAmount.text = self.sellAmountVar
                }
            }
            
            if let dotIndexFirst = sellAmountVar.firstIndex(of: "."), let dotIndexLast = sellAmountVar.lastIndex(of: ".") {
                if sellAmountVar.distance(from: dotIndexFirst, to: sellAmountVar.endIndex) - 1 > 2 {
                    DispatchQueue.main.async {
                        self.sellAmountVar = oldValue
//                        self.sellAmount.text = self.sellAmountVar
                    }
                }
                
                if dotIndexFirst != dotIndexLast {
                    DispatchQueue.main.async {
                        self.sellAmountVar = oldValue
//                        self.sellAmount.text = self.sellAmountVar
                    }
                }
            }
        }
    }
    
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
        let alertController = UIAlertController(title: "Success", message: "You have successfully created a dummy alert", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel))
        alertController.setBackgroundColor(color: ColorConstants.homeViewBackground)
        alertController.setTitleFontAndColor()
        alertController.setMessageFontAndColor()
        alertController.setTint()
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func dialpadAdded(_ sender: UIButton) {
        sellAmountVar += sender.titleLabel?.text ?? ""
//        sellAmount.text = sellAmountVar
    }
    
    @IBAction func dialpadDeleted(_ sender: UIButton) {
        if sellAmountVar.count > 0 {
            sellAmountVar.removeLast()
//            sellAmount.text = sellAmountVar
        }
    }
}
