//
//  ProductCell.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 10/31/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit
import StoreKit

class ProductTableViewCell: UITableViewCell {
    static let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.formatterBehavior = .behavior10_4
        formatter.numberStyle = .currency
        
        return formatter
    }()
    
    var buyButtonHandler: ((_ product: SKProduct) -> ())?
    
    var product: SKProduct? {
        didSet {
            guard let product = product else { return }
            print("Trying to set text label in product")
            textLabel?.text = product.localizedTitle
            
            if RecipeSetProducts.store.isProductPurchased(product.productIdentifier) {
                print("isProductPurchased")
                accessoryType = .checkmark
                accessoryView = nil
                detailTextLabel?.text = ""
            } else if IAPHelper.canMakePayments() {
                ProductTableViewCell.priceFormatter.locale = product.priceLocale
                detailTextLabel?.text = ProductTableViewCell.priceFormatter.string(from: product.price)
                print("Can Make Payments")
                accessoryType = .none
                accessoryView = self.newBuyButton()
            } else {
                print("Not Available")
                detailTextLabel?.text = "Not available"
            }
        }
    }
    
    override func prepareForReuse() {
        print("Before prepare for reuse")
        super.prepareForReuse()
        
        textLabel?.text = ""
        detailTextLabel?.text = ""
        accessoryView = nil
    }
    
    func newBuyButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitleColor(tintColor, for: UIControlState())
        button.setTitle("Buy", for: UIControlState())
        button.addTarget(self, action: #selector(ProductTableViewCell.buyButtonTapped(_:)), for: .touchUpInside)
        button.sizeToFit()
        
        return button
    }
    
    func buyButtonTapped(_ sender: AnyObject) {
        buyButtonHandler?(product!)
    }
 
}
