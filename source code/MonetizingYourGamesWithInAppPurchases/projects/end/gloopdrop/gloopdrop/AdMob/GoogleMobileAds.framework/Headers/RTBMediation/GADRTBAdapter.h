/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADRTBAdapter.h
//  Google Mobile Ads SDK
//
//  Copyright 2018 Google LLC. All rights reserved.
//

#import <GoogleMobileAds/Mediation/GADMediationAdapter.h>
#import <GoogleMobileAds/RTBMediation/GADRTBRequestParameters.h>
#import <UIKit/UIKit.h>

/// Completion handler for signal generation. Returns either signals or an error object.
typedef void (^GADRTBSignalCompletionHandler)(NSString *_Nullable signals,
                                              NSError *_Nullable error);

/// Adapter that provides signals to the Google Mobile Ads SDK to be included in an auction.
@protocol GADRTBAdapter <GADMediationAdapter>

/// Returns an initialized RTB adapter.
- (nonnull instancetype)init;

/// Asks the receiver for encrypted signals. Signals are provided to the 3PAS at request time. The
/// receiver must call completionHandler with signals or an error.
///
/// This method is called on a non-main thread. The receiver should avoid using the main thread to
/// prevent signal collection timeouts.
- (void)collectSignalsForRequestParameters:(nonnull GADRTBRequestParameters *)params
                         completionHandler:(nonnull GADRTBSignalCompletionHandler)completionHandler;

@end
