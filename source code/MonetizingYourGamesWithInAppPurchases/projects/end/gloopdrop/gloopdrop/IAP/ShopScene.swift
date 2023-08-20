//
//  ShopScene.swift
//  gloopdrop
//
//  Created by Tammy Coron on 1/24/2020.
//  Copyright © 2020 Just Write Code LLC. All rights reserved.
//

import SpriteKit
import StoreKit

struct ShopMessages {
  static let welcome = "Welcome to the Shop!"
  static let success = "Thank you! Enjoy your purchase."
  static let restored = "Excellent! Your purchases have been restored."
  static let restoredComplete = "Restoration complete."
  static let makingPurchase = "Standby, attempting to make purchase."
  static let restoringPurchases = "Standby, attempting to restore purchases."
}

class ShopScene: SKReferenceNode {
  
  // MARK: - PROPERTIES
  private weak var gameScene: GameScene?
  
  // MARK: - INIT
  convenience init(in scene: GameScene) {
    self.init(fileNamed: "ShopScene")
    
    self.gameScene = scene
  }
  
  override init(fileNamed fileName: String?) {
    super.init(fileNamed: fileName)
    
    self.name = "shopScene"
    self.zPosition = Layer.shop.rawValue
    self.alpha = 0.0
    self.setScale(1.0)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func beginInteraction() {
    updateMessageText(with: ShopMessages.welcome) // reset message text
    updateUI() // reset UI
    
    let scale = SKAction.scale(to: 1.0, duration: 0.15)
    let fade = SKAction.fadeIn(withDuration: 0.15)
    let group = SKAction.group([fade, scale])
    run(group, completion: {})
  }
  
  func endInteraction() {
    let scale = SKAction.scale(to: 0.25, duration: 0.15)
    let fade = SKAction.fadeOut(withDuration: 0.15)
    let group = SKAction.group([fade, scale])
    run(group, completion: {})
  }
  
  // MARK: - STORE FUNCTIONS
  
  func purchaseProduct(node: SKNode) {
    let productIdentifier = node.userData?.value(forKey: "productId") as? String
    
    if let product = StoreManager.shared.availableProducts.first(where:
      { $0.productIdentifier == productIdentifier }) {
      updateMessageText(with: ShopMessages.makingPurchase)
      StoreManager.shared.buyProduct(product: product, qty: 1)
    }
  }
  
  func restorePurchases() {
    updateMessageText(with: ShopMessages.restoringPurchases)
    StoreManager.shared.restoreProducts()
  }
  
  func updateMessageText(with message: String?) {
    if let shopMessage = childNode(withName: "//shop.message") as? SKLabelNode {
      shopMessage.text = message
    }
  }
}


// MARK: - NOTIFICATIONS FOR THE SHOP

extension ShopScene {
  
  func setupObservers() {
    
    // Add notification observers
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(self.purchaseSuccess(_:)),
                                           name: .purchaseSuccess,
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(self.purchaseFailure(_:)),
                                           name: .purchaseFailure,
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(self.restoredSuccess),
                                           name: .restoredSuccess,
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(self.restoredComplete),
                                           name: .restoredComplete,
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(self.restoredFailure),
                                           name: .restoredFailure,
                                           object: nil)
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(self.requestComplete),
                                           name: .productsRequestComplete,
                                           object: nil)
    
  }
  
  @objc func purchaseSuccess(_ notification: Notification) {
    updateMessageText(with: ShopMessages.success)
    if let productIdentifier = notification.object as? String {
      let product = StoreProducts.Product(productID: productIdentifier)
      
      if let gp = GameData.shared.products.first(where:
        { $0.id == productIdentifier }) {
        gp.quantity += 1
      } else {
        product.quantity = 1
        GameData.shared.products.append(product)
      }
    }
    updateUI()
  }
  
  @objc func purchaseFailure(_ notification: Notification) {
    let message = notification.object as? String
    updateMessageText(with: message)
  }
  
  @objc func restoredSuccess(_ notification: Notification) {
    updateMessageText(with: ShopMessages.restored)
    if let productIdentifier = notification.object as? String {
      let product = StoreProducts.Product(productID: productIdentifier)
      
      if let gp = GameData.shared.products.first(where:
        { $0.id == productIdentifier }) {
        gp.quantity += 1
      } else {
        product.quantity = 1
        GameData.shared.products.append(product)
      }
    }
    updateUI()
  }
  
  @objc func restoredComplete(_ notification: Notification) {
    updateMessageText(with: ShopMessages.restoredComplete)
    updateUI()
  }
  
  @objc func restoredFailure(_ notification: Notification) {
    updateMessageText(with: notification.object as? String)
  }
  
  @objc func requestComplete(_ notification: Notification) {
    setupShop()
  }
}

// MARK: - CUSTOMIZATIONS FOR THE SHOP

extension ShopScene {
  
  func setupShop() {
    for product in StoreManager.shared.availableProducts {
      setupProduct(product)
    }
  }
  
  func setupProduct(_ product: SKProduct) {
    if let id = StoreManager.shared.resourceNameForProductIdentifier(product.productIdentifier) {
      let productNodeName = "shop.product.\(id)"
      
      let productTitleNodeName = "//\(productNodeName)/title"
      let titleLabelNode = childNode(withName: productTitleNodeName) as? SKLabelNode
      titleLabelNode?.text = product.localizedTitle
      
      let productImageNodeName = "//\(productNodeName)/image"
      if let imageNode = childNode(withName: productImageNodeName) as? SKSpriteNode {
        setupImageFor(node: imageNode, productID: product.productIdentifier)
      }
      
      let productDescriptionNodeName = "//\(productNodeName)/description"
      let descriptionLabelNode = childNode(withName: productDescriptionNodeName) as? SKLabelNode
      descriptionLabelNode?.text = product.localizedDescription
      
      let productPriceNodeName = "//\(productNodeName)/unowned/price"
      let priceLabelNode = childNode(withName: productPriceNodeName) as? SKLabelNode
      priceLabelNode?.text = product.regularPrice
      
      let productBuyNodeName = "//\(productNodeName)/unowned/buy"
      if let buyNode = childNode(withName: productBuyNodeName) as? SKSpriteNode {
        setUserDataFor(node: buyNode, productID: product.productIdentifier)
      }
    }
  }
  
  func setUserDataFor(node: SKNode, productID: String) {
    let product = StoreManager.shared.resourceInformationForProductIdentifier(productID)
    node.userData = NSMutableDictionary()
    node.userData?.setValue(product.id, forKey: "productId")
    node.userData?.setValue(product.quantity, forKey: "quantity")
  }
  
  func setupImageFor(node: SKSpriteNode, productID: String) {
    let product = StoreManager.shared.resourceInformationForProductIdentifier(productID)
    let resourceName = StoreManager.shared.resourceNameForProductIdentifier(productID) ?? ""
    
    var imageName = resourceName.replacingOccurrences(of: ".", with: "-")
    
    let textureAtlas = SKTextureAtlas(named: "shop_iaps")
    if textureAtlas.textureNames.contains(imageName) == false {
      imageName = imageName.replacingOccurrences(of: "-\(product.quantity)", with: "")
      if textureAtlas.textureNames.contains(imageName) == false {
        node.texture = SKTexture(imageNamed: "none")
      }
    }
    
    node.texture = SKTexture(imageNamed: imageName)
  }
  
  func updateUI() {
    gameScene?.updateContinueButton()
    
    for product in GameData.shared.products {
      if let id =
       StoreManager.shared.resourceNameForProductIdentifier(product.id) {
        let productNodeName = "shop.product.\(id)"
        if product.isConsumable == false {
          let ownedNodeName = "//\(productNodeName)/owned"
          let ownedNode = childNode(withName: ownedNodeName)
          ownedNode?.isHidden = false
          // print("   ownedNodeName: \(ownedNodeName)")
          
          let unownedNodeName = "//\(productNodeName)/unowned"
          let unownedNode = childNode(withName: unownedNodeName)
          unownedNode?.isHidden = true
          // print("   unownedNodeName: \(unownedNodeName)")
        }
      }
    }
  }
}
