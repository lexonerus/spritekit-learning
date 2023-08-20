/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADSearchBannerView.h
//  Google Mobile Ads SDK
//
//  Copyright 2011 Google LLC. All rights reserved.
//

#import <GoogleMobileAds/GADAdSizeDelegate.h>
#import <GoogleMobileAds/GADBannerView.h>

/// A view that displays search ads.
/// To show search ads:
///   1) Create a GADSearchBannerView and add it to your view controller's view hierarchy.
///   2) Create a GADDynamicHeightSearchRequest object to hold the search query and other search
///   data.
///   3) Call GADSearchBannerView's -loadRequest: method with the
///   GADDynamicHeightSearchRequest object.
@interface GADSearchBannerView : GADBannerView

/// If the banner view is initialized with kGADAdSizeFluid and the corresponding request is created
/// with dynamic height parameters, this delegate will be called when the ad size changes.
@property(nonatomic, weak, nullable) IBOutlet id<GADAdSizeDelegate> adSizeDelegate;

@end
