/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADPresentError.h
//  Google Mobile Ads SDK
//
//  Copyright 2019 Google LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GADRequestError.h>

/// Error codes in the Google Mobile Ads SDK domain that surface due to errors when attempting to
/// present an ad.
typedef NS_ENUM(NSInteger, GADPresentationErrorCode) {

  /// Ad isn't ready to be shown.
  GADPresentationErrorCodeAdNotReady = 15,

  /// Ad is too large for the scene.
  GADPresentationErrorCodeAdTooLarge = 16,

  /// Internal error.
  GADPresentationErrorCodeInternal = 17,

  /// Ad has already been used.
  GADPresentationErrorCodeAdAlreadyUsed = 18,

  /// Attempted to present ad from a non-main thread.
  GADPresentationErrorNotMainThread = 21,
};
