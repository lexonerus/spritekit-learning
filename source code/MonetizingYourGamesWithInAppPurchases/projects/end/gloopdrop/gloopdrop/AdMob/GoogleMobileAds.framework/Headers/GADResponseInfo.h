/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADResponseInfo.h
//  Google Mobile Ads SDK
//
//  Copyright 2019-2020 Google LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Response metadata for an individual ad network in an ad response.
@interface GADAdNetworkResponseInfo : NSObject

/// A class name that identifies the ad network.
@property(nonatomic, readonly, nonnull) NSString *adNetworkClassName;

/// Network configuration set on the AdMob UI.
@property(nonatomic, readonly, nonnull) NSDictionary<NSString *, id> *credentials;

/// Error associated with the request to the network. Nil if the network successfully loaded an ad
/// or if the network was not attempted.
@property(nonatomic, readonly, nullable) NSError *error;

/// Amount of time the ad network spent loading an ad. 0 if the network was not attempted.
@property(nonatomic, readonly) NSTimeInterval latency;

@end

/// Ad network class name for ads returned from Google's ad network.
extern NSString *_Nonnull const GADGoogleAdNetworkClassName;

/// Ad network class name for custom event ads.
extern NSString *_Nonnull const GADCustomEventAdNetworkClassName;

/// Key into NSError.userInfo mapping to a GADResponseInfo object. When ads fail to load, errors
/// returned contain an instance of GADResponseInfo.
extern NSString *_Nonnull GADErrorUserInfoKeyResponseInfo;

/// Information about a response to an ad request.
@interface GADResponseInfo : NSObject

/// Unique identifier of the ad response.
@property(nonatomic, readonly, nullable) NSString *responseIdentifier;

/// A class name that identifies the ad network that returned the ad. Nil if no ad was returned.
@property(nonatomic, readonly, nullable) NSString *adNetworkClassName;

/// Array of metadata for each ad network included in the response.
@property(nonatomic, readonly, nonnull) NSArray<GADAdNetworkResponseInfo *> *adNetworkInfoArray;

@end
