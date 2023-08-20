/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADMediationServerConfiguration.h
//  Google Mobile Ads SDK
//
//  Copyright 2018 Google LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GADAdFormat.h>

/// Mediation configuration set by the publisher on the AdMob UI.
@interface GADMediationCredentials : NSObject

/// The AdMob UI settings.
@property(nonatomic, readonly, nonnull) NSDictionary<NSString *, id> *settings;

/// The ad format associated with the credentials.
@property(nonatomic, readonly) GADAdFormat format;

@end

/// Third party SDK configuration.
@interface GADMediationServerConfiguration : NSObject

/// Array of mediation configurations set by the publisher on the AdMob UI. Each configuration is a
/// possible credential dictionary that the Google Mobile Ads SDK may provide at ad request time.
@property(nonatomic, readonly, nonnull) NSArray<GADMediationCredentials *> *credentials;

@end
