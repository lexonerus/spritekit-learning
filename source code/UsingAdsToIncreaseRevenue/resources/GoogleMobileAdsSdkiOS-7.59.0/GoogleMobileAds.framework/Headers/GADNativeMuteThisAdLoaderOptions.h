/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADNativeMuteThisAdLoaderOptions.h
//  Google Mobile Ads SDK
//
//  Copyright 2018 Google LLC. All rights reserved.
//

#import <GoogleMobileAds/GADAdLoader.h>

/// Mute This Ad options.
@interface GADNativeMuteThisAdLoaderOptions : GADAdLoaderOptions

/// Set to YES to request the custom Mute This Ad feature. By default, this property's value is YES.
@property(nonatomic) BOOL customMuteThisAdRequested;

@end
