//
//  StoreProducts.swift
//  gloopdrop
//
//  Created by Tammy Coron on 1/24/2020.
//  Copyright © 2020 Just Write Code LLC. All rights reserved.
//

import StoreKit

/* The recommendation is to use your bundle id and a set of product identifiers that
   include a 'somewhat unique' name and a quantity. For example:
 
   "net.justwritecode.gloopdrop.continue" <-- consumable with a default quantity of 1
   "net.justwritecode.gloopdrop.continue.1" <-- consumable with an explicit quantity of 1
   "net.justwritecode.gloopdrop.continue.3" <-- consumable with an explicit quantity of 3
 
   "net.justwritecode.gloopdrop.removeads"   <-- non-consumable with a default quantity of 1
   "net.justwritecode.gloopdrop.removeads.1" <-- non-consumable with an explicit quantity of 1
 
   In all cases, the full product identifier must be unique and can never be re-used, even after
   its been deleted on the App Store, so ** USE CAUTION ** when setting up.
 
   NOTE: When parsing product identifiers, this helper code will always assume the last
         component ("." separated) in the string represents the consumable quantity amount.
         For example, if the last component in the string is `1`, the quantity will be `1`.
 
         The recommendation is to avoid mixing numbers and letters. For example, don't use
         `net.justwritecode.gloopdrop.continue1`. If you do, the helper code will parse the numbers
         in the last component and use those as the quantity.
         
         Either end the product identifier with a number that represents the quantity or omit the
         quantity amount completely, and let the helper code assign a default quantity value of `1`.
 
         When naming your IAP image for display in the UI, use the following formats:
         
         - `continue`  : Use the last component of the product identifier when it's
                         a consumable with a default quantity of 1.
         - `continue-3`: Use the last component of the product identifier
                         plus a hyphen and the quantity when it's a consumable with a defined quantity.
         - `removeads` : Use the last component of the product identifier when it's a non-consumable.
 
   In this file, you'll set up three things:
 
    - `prefixID`: String <-- Typically, this is your bundle id, including a trailing dot
    - `productIDsConsumables`: Set<String> <-- An array of consumable product identifiers
    - `productIDsNonConsumables`: Set<String> <-- An array of non-consumable product identifiers
   
   This helper code strips the `prefixID`, and then matches the corresponding product node
   within the `ShopScene.sks` file using its `name`. It does this so that is can dynamically
   populate the UI.
   
   For example, if you have an IAP named "net.justwritecode.gloopdrop.continue.1",
   you can set the `prefixID` to "net.justwritecode.gloopdrop." and the
   product node's `name` (within the `ShopScene.sks` file) to "shop.product.continue.1".
 
   Here's how it works:
    
     1. Parse the product identifier and strip the `prefixID`, which is `net.justwritecode.gloopdrop.`
     2. Add a new prefix, which is a hard-coded value of `shop.product.`
     3. Use the result to search the node tree for a matching node:
        - `childNode(withName: "//shop.product.continue.1/image")`
        - `childNode(withName: "//shop.product.continue.1/title")`
        - `childNode(withName: "//shop.product.continue.1/description")`
        - `childNode(withName: "//shop.product.continue.1/price")`
        - `childNode(withName: "//shop.product.continue.1/unowned/buy")`
 
   During scene set up, the helper code sets the `buy` node's `userData` property to match the
   full product identifier and quantity, which is needed to make the purchase:
    - `node.userData?.setValue(product.id, forKey: "productId")`
    - `node.userData?.setValue(product.quantity, forKey: "quantity")`
 
   When you set up the `productIDsConsumables` and `productIDsNonConsumables` arrays, you can use
   the `prefixID` to make it easier. For example: `"\(prefixID)continue.1"`
 */

struct StoreProducts: Codable {
  
  static let prefixID = "{your bundle id}" // include trailing dot
  
  static let productIDsConsumables: Set<String> = [
    "\(prefixID){productid.qty}"
  ]
  static let productIDsNonConsumables: Set<String> = [
    "\(prefixID){productid}"
  ]
  
  class Product: NSObject, Codable {
    var id: String!
    
    var isConsumable: Bool = false
    var quantity: Int = 1
    
    init(productID pid: String) {
      self.id = pid
      
      if StoreProducts.productIDsConsumables.contains(pid) {
        isConsumable = true
      }
    }
  }
}
