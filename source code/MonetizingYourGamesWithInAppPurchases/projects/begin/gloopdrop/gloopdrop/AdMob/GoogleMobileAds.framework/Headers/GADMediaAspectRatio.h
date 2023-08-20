/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADMediaAspectRatio.h
//  Google Mobile Ads SDK
//
//  Copyright 2019 Google LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Media aspect ratio.
typedef NS_ENUM(NSInteger, GADMediaAspectRatio) {
  /// Unknown media aspect ratio.
  GADMediaAspectRatioUnknown = 0,
  /// Any media aspect ratio.
  GADMediaAspectRatioAny = 1,
  /// Landscape media aspect ratio.
  GADMediaAspectRatioLandscape = 2,
  /// Portrait media aspect ratio.
  GADMediaAspectRatioPortrait = 3,
  /// Close to square media aspect ratio. This is not a strict 1:1 aspect ratio.
  GADMediaAspectRatioSquare = 4
};
