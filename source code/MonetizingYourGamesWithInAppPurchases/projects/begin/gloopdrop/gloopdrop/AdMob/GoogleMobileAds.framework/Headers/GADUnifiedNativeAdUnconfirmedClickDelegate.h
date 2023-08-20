/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADUnifiedNativeAdUnconfirmedClickDelegate.h
//  Google Mobile Ads SDK
//
//  Copyright 2017 Google LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GADUnifiedNativeAdAssetIdentifiers.h>

@class GADUnifiedNativeAd;

/// Delegate methods for handling unified native ad unconfirmed clicks.
@protocol GADUnifiedNativeAdUnconfirmedClickDelegate <NSObject>

/// Tells the delegate that native ad receives an unconfirmed click on view with asset ID. You
/// should update user interface and ask user to confirm the click once this message is received.
/// Use the -registerClickConfirmingView: method in GADUnifiedNativeAd+ConfirmedClick.h to register
/// a view that will confirm the click. Only called for Google ads and is not supported for mediated
/// ads.
- (void)nativeAd:(nonnull GADUnifiedNativeAd *)nativeAd
    didReceiveUnconfirmedClickOnAssetID:(nonnull GADUnifiedNativeAssetIdentifier)assetID;

/// Tells the delegate that the unconfirmed click is cancelled. You should revert the user interface
/// change once this message is received. Only called for Google ads and is not supported for
/// mediated ads.
- (void)nativeAdDidCancelUnconfirmedClick:(nonnull GADUnifiedNativeAd *)nativeAd;

@end
