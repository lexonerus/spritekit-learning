/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADAdChoicesView.h
//  Google Mobile Ads SDK
//
//  Copyright 2016 Google LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

/// Displays AdChoices content.
///
/// If a GADAdChoicesView is set on GADUnifiedNativeAdView prior to calling -setNativeAd:, AdChoices
/// content will render inside the GADAdChoicesView. By default, AdChoices is placed in the top
/// right corner of GADUnifiedNativeAdView.
@interface GADAdChoicesView : UIView
@end
