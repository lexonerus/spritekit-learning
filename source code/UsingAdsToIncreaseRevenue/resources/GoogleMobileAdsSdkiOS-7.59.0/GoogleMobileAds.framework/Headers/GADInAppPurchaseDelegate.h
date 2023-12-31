/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADInAppPurchaseDelegate.h
//  Google Mobile Ads SDK
//
//  Copyright 2013 Google LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAdsDefines.h>

@class GADDefaultInAppPurchase;
@class GADInAppPurchase;

#pragma mark - Default Purchase Flow

/// In-app purchase delegate protocol for default purchase handling. The delegate must deliver
/// the purchased item then call the GADDefaultInAppPurchase object's finishTransaction method.
GAD_DEPRECATED_ATTRIBUTE
@protocol GADDefaultInAppPurchaseDelegate <NSObject>

/// Called when the user successfully paid for a purchase. You must first deliver the purchased
/// item to the user, then call defaultInAppPurchase's finishTransaction method.
- (void)userDidPayForPurchase:(nonnull GADDefaultInAppPurchase *)defaultInAppPurchase;

@optional

/// Called when the user clicks on the buy button of an in-app purchase ad. Return YES if the
/// default purchase flow should be started to purchase the item, otherwise return NO. If not
/// implemented, defaults to YES.
- (BOOL)shouldStartPurchaseForProductID:(nonnull NSString *)productID quantity:(NSInteger)quantity;

@end

#pragma mark - Custom Purchase Flow

/// In-app purchase delegate protocol for custom purchase handling. The delegate must handle the
/// product purchase flow then call the GADInAppPurchase object's reportPurchaseStatus: method.
GAD_DEPRECATED_ATTRIBUTE
@protocol GADInAppPurchaseDelegate <NSObject>

/// Called when the user clicks on the buy button of an in-app purchase ad. After the receiver
/// handles the purchase, it must call the GADInAppPurchase object's reportPurchaseStatus: method.
- (void)didReceiveInAppPurchase:(nonnull GADInAppPurchase *)purchase;

@end
