/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADRewardedAdMetadataDelegate.h
//  Google Mobile Ads SDK
//
//  Copyright 2018 Google LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GADAdMetadata.h>

@class GADRewardedAd;

/// Delegate for receiving metadata change messages from a GADRewardedAd.
@protocol GADRewardedAdMetadataDelegate <NSObject>

@optional

/// Tells the delegate that the rewarded ad's metadata changed. Called when an ad loads, and when a
/// loaded ad's metadata changes.
- (void)rewardedAdMetadataDidChange:(nonnull GADRewardedAd *)rewardedAd;

@end
