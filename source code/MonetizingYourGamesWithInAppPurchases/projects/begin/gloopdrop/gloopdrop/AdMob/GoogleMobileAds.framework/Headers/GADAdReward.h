/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADAdReward.h
//  Google Mobile Ads SDK
//
//  Copyright 2015 Google LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Reward information for GADRewardBasedVideoAd ads.
@interface GADAdReward : NSObject

/// Type of the reward.
@property(nonatomic, readonly, nonnull) NSString *type;

/// Amount rewarded to the user.
@property(nonatomic, readonly, nonnull) NSDecimalNumber *amount;

/// Returns an initialized GADAdReward with the provided reward type and reward amount.
- (nonnull instancetype)initWithRewardType:(nonnull NSString *)rewardType
                              rewardAmount:(nonnull NSDecimalNumber *)rewardAmount
    NS_DESIGNATED_INITIALIZER;

@end
