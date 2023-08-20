/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADAdValue.h
//  Google Mobile Ads SDK
//
//  Copyright 2019 Google LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GADAdValuePrecision) {
  /// An ad value with unknown precision.
  GADAdValuePrecisionUnknown = 0,
  /// An ad value estimated from aggregated data.
  GADAdValuePrecisionEstimated = 1,
  /// A publisher-provided ad value, such as manual CPMs in a mediation group.
  GADAdValuePrecisionPublisherProvided = 2,
  /// The precise value paid for this ad.
  GADAdValuePrecisionPrecise = 3
};

@class GADAdValue;

/// Handles ad events that are estimated to have earned money.
typedef void (^GADPaidEventHandler)(GADAdValue *_Nonnull value);

/// The monetary value earned from an ad.
@interface GADAdValue : NSObject <NSCopying>

/// The precision of the reported ad value.
@property(nonatomic, readonly) GADAdValuePrecision precision;

/// The ad's value.
@property(nonatomic, nonnull, readonly) NSDecimalNumber *value;

/// The value's currency code.
@property(nonatomic, nonnull, readonly) NSString *currencyCode;

@end
