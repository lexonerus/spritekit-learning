//
//  StoreManager.swift
//  gloopdrop
//
//  Created by Tammy Coron on 1/24/2020.
//  Copyright © 2020 Just Write Code LLC. All rights reserved.
//

import StoreKit

// Custom notifications you can use to keep track of the IAP transaction status
extension Notification.Name {
  static let purchaseSuccess = Notification.Name("purchaseSuccess")
  static let purchaseFailure = Notification.Name("purchaseFailure")
  
  static let restoredSuccess = Notification.Name("restoredSuccess")
  static let restoredComplete = Notification.Name("restoredComplete")
  static let restoredFailure = Notification.Name("restoredFailure")
  
  static let productsRequestComplete = Notification.Name("productsRequestComplete")
}

// Custom class to handle the IAP store interactions
class StoreManager: NSObject {
  private var productIdentifiers: Set<String> = []
  // Uses data stored in `StoreProducts.swift`
  
  var availableProducts = [SKProduct]()
  var invalidProductIdentifiers = [String]()
  
  var purchasedTransactions = [SKPaymentTransaction]()
  var restoredTransactions = [SKPaymentTransaction]()
  
  private var productsRequest: SKProductsRequest?
  
  static let shared: StoreManager = {
    let instance = StoreManager()
    instance.productIdentifiers = StoreProducts.productIDsConsumables.union(StoreProducts.productIDsNonConsumables)
    
    return instance
  }()
  
  private override init() {}
}

// MARK: - DELEGATE EXTENSIONS

/* ############################################################ */
/*      STOREKIT DELEGATE & OBSERVER FUNCTIONS STARTS HERE      */
/* ############################################################ */

// MARK: - SKProductsRequestDelegate

extension StoreManager: SKProductsRequestDelegate {
  
  /// Required: Accepts the App Store response that contains the app-requested product information.
  func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
    print("productsRequest(_:didReceive)")
    
    // Populate the `availableProducts` array
    if !response.products.isEmpty {
      availableProducts = response.products
    }
    
    // Populate the `invalidProductIdentifiers` array
    if !response.invalidProductIdentifiers.isEmpty {
      invalidProductIdentifiers = response.invalidProductIdentifiers
    }
    
    // For testing and verifying
    for p in availableProducts {
      print(" - Product (available): \(p.productIdentifier) "
            + "\(p.localizedTitle) \(p.price.floatValue)")
    }
    
    for p in invalidProductIdentifiers {
      print(" - Product (invalid): \(p)")
    }
    
    // Send notification that the products request operation is complete
    NotificationCenter.default.post(name: .productsRequestComplete, object: nil)
  }
}

// MARK: - SKRequestDelegate

extension StoreManager: SKRequestDelegate {
  
  /// Optional: Tells the delegate that the request has completed.
  func requestDidFinish(_ request: SKRequest) {
    print("requestDidFinish(_:)")
    
    productsRequest = .none
  }
  
  /// Optional: Tells the delegate that the request failed to execute.
  func request(_ request: SKRequest, didFailWithError error: Error) {
    print("request(_:didFailWithError: \(error.localizedDescription)")
    
    productsRequest = .none
  }
}

// MARK: - SKPaymentTransactionObserver

extension StoreManager: SKPaymentTransactionObserver {
  
  /// Required: Tells an observer that one or more transactions have been updated.
  func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
    for transaction in transactions {
      switch (transaction.transactionState) {
      case .purchased:
        
        purchasedTransactions.append(transaction)
        NotificationCenter.default.post(name: .purchaseSuccess,
                                        object: transaction.payment.productIdentifier)
        
        SKPaymentQueue.default().finishTransaction(transaction)
        
        break
      case .failed:
        
        NotificationCenter.default.post(name: .purchaseFailure,
                                        object: transaction.error?.localizedDescription)
        
        SKPaymentQueue.default().finishTransaction(transaction)
        
        break
      case .restored:
        guard let productIdentifier = transaction.original?.payment.productIdentifier else { return }
        
        restoredTransactions.append(transaction)
        NotificationCenter.default.post(name: .restoredSuccess, object: productIdentifier)
        
        SKPaymentQueue.default().finishTransaction(transaction)
        
        break
      case .deferred:
        break
      case .purchasing:
        break
      @unknown default:
        fatalError()
      }
    }
  }
  
  /// Optional: Tells an observer that one or more transactions have been removed from the queue.
  // func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {}
  
  /// Optional: Tells the observer that an error occurred while restoring transactions.
  func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
    print("paymentQueue(_:restoreCompletedTransactionsFailedWithError:)")
    NotificationCenter.default.post(name: .restoredFailure, object: error.localizedDescription)
  }
  
  /// Optional: Tells the observer that the payment queue has finished sending restored transactions.
  func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
    print("paymentQueueRestoreCompletedTransactionsFinished(_:)")
    NotificationCenter.default.post(name: .restoredComplete, object: nil)
  }
  
  /// Optional: Tells the observer that the payment queue has updated one or more download objects.
  // func paymentQueue(_ queue: SKPaymentQueue, updatedDownloads downloads: [SKDownload]) {}
  
  /// Optional: Tells the observer that a user initiated an in-app purchase from the App Store.
  // func paymentQueue(_ queue: SKPaymentQueue, shouldAddStorePayment payment: SKPayment, for product: SKProduct) -> Bool { // Return `true` to continue the transaction in your app. // Return `false` to defer or cancel the transaction.}
  
  /// Optional: Tells the observer that the storefront for the payment queue has changed.
  // func paymentQueueDidChangeStorefront(_ queue: SKPaymentQueue) {}
}

// MARK: - StoreManager Extension & Helpers
/// Custom extension to handle specific IAP interactions

extension StoreManager {
  
  /* This property dynamically checks to make sure the user is authorized to make
   payments. For example, you can use this method to check if parental controls are
   enabled that prevents unauthorized payments from occurring. */
  var isAuthorizedForPayments: Bool {
    return SKPaymentQueue.canMakePayments()
  }
  
  /* This method sends a request to the App Store for a current list of products.
   It uses the supplied product identifiers (`self.productIdentifiers`) to
   download the current list of available products. */
  func fetchProducts() {
    productsRequest?.cancel()
    productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
    productsRequest?.delegate = self
    productsRequest?.start()
  }
  
  /* This method sends a request to restore the user's purchases. This includes
   only non-consumables and auto-renewable subscriptions, and only if you called
   `finishTransaction(_:)` on the initial purchase. */
  func restoreProducts() {
    if !restoredTransactions.isEmpty {
      restoredTransactions.removeAll()
    }
    SKPaymentQueue.default().restoreCompletedTransactions()
  }
  
  /* Use this method to purchase the product with the matching product identifier.
   To purchase more than one of this product, adjust the `payment.quantity` value
   using the `qty` parameter. */
  func buyProduct(product: SKProduct, qty: Int) {
    let payment = SKMutablePayment(product: product)
    payment.quantity = qty
    SKPaymentQueue.default().add(payment)
  }
  
  /* Use this method to parse the product identifier and remove the `prefixID`.
   Returns the product identifier without the `prefixID`. */
  func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
    let product = StoreProducts.Product(productID: productIdentifier)
    return product.id.replacingOccurrences(of: StoreProducts.prefixID, with: "")
  }
  
  /* Use this method to parse the product identifier to determine its quantity.
   Returns the complete StoreProducts.Product object. */
  func resourceInformationForProductIdentifier(_ productIdentifier: String) -> StoreProducts.Product {
    let product = StoreProducts.Product(productID: productIdentifier)
    
    let qty = productIdentifier.components(separatedBy: ".").last ?? ""
    let numbers = Int(qty.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")) ?? 1
    product.quantity = numbers
    
    return product
  }
}

// MARK: - StoreKit Extentions & Helpers

extension SKProduct {
  var regularPrice: String? {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = self.priceLocale
    return formatter.string(from: self.price)
  }
}
