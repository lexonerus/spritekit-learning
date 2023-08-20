/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADMediationAdSize.h
//  Google Mobile Ads SDK
//
//  Copyright 2019 Google. All rights reserved.
//

#import <GoogleMobileAds/GADAdSize.h>

/// Returns the closest valid ad size from possibleAdSizes as compared to |original|. The selected
/// size must be smaller than or equal in size to the original. The selected size must also be
/// within a configurable fraction of the width and height of the original. If no valid size exists,
/// returns kGADAdSizeInvalid.
GAD_EXTERN GADAdSize GADClosestValidSizeForAdSizes(GADAdSize original,
                                                   NSArray<NSValue *> *_Nonnull possibleAdSizes);
