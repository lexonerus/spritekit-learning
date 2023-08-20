/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "FBLPromise+All.h"
#import "FBLPromise+Always.h"
#import "FBLPromise+Any.h"
#import "FBLPromise+Async.h"
#import "FBLPromise+Await.h"
#import "FBLPromise+Catch.h"
#import "FBLPromise+Delay.h"
#import "FBLPromise+Do.h"
#import "FBLPromise+Race.h"
#import "FBLPromise+Recover.h"
#import "FBLPromise+Reduce.h"
#import "FBLPromise+Retry.h"
#import "FBLPromise+Testing.h"
#import "FBLPromise+Then.h"
#import "FBLPromise+Timeout.h"
#import "FBLPromise+Validate.h"
#import "FBLPromise+Wrap.h"
#import "FBLPromise.h"
#import "FBLPromiseError.h"
#import "FBLPromises.h"

FOUNDATION_EXPORT double FBLPromisesVersionNumber;
FOUNDATION_EXPORT const unsigned char FBLPromisesVersionString[];

