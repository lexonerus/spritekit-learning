//
//  AdMobHelper.swift
//  gloopdrop
//
//  Created by Tammy Coron on 1/24/2020.
//  Copyright © 2020 Just Write Code LLC. All rights reserved.
//

import Foundation
import GoogleMobileAds

// MARK: - DELEGATE EXTENSIONS

/* ############################################################ */
/*             ADMOB DELEGATE FUNCTIONS STARTS HERE             */
/* ############################################################ */

extension GameViewController : GADBannerViewDelegate {
  
  // MARK: - GADBannerViewDelegate: Ad Request Lifecycle Notifications
  
  /// Tells the delegate an ad request loaded an ad.
  func adViewDidReceiveAd(_ bannerView: GADBannerView) {
    print("adViewDidReceiveAd")
  }
  
  /// Tells the delegate an ad request failed.
  func adView(_ bannerView: GADBannerView,
              didFailToReceiveAdWithError error: GADRequestError) {
    print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
  }
  
  // MARK: - GADBannerViewDelegate: Click-Time Lifecycle Notifications
  
  /// Tells the delegate that a full-screen view will be presented in response
  /// to the user clicking on an ad.
  func adViewWillPresentScreen(_ bannerView: GADBannerView) {
    print("adViewWillPresentScreen")
  }
  
  /// Tells the delegate that the full-screen view will be dismissed.
  func adViewWillDismissScreen(_ bannerView: GADBannerView) {
    print("adViewWillDismissScreen")
  }
  
  /// Tells the delegate that the full-screen view has been dismissed.
  func adViewDidDismissScreen(_ bannerView: GADBannerView) {
    print("adViewDidDismissScreen")
  }
  
  /// Tells the delegate that a user click will open another app (such as
  /// the App Store), backgrounding the current app.
  func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
    print("adViewWillLeaveApplication")
  }
}

extension GameViewController: GADRewardedAdDelegate {
  
  // MARK: - GADRewardedAdDelegate: Lifecycle Notifications
  
  /// Tells the delegate that the user earned a reward.
  func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
    print("Reward received: \(reward.type) | amount: \(reward.amount).")
  }
  
  /// Tells the delegate that the rewarded ad was presented.
  func rewardedAdDidPresent(_ rewardedAd: GADRewardedAd) {
    print("Rewarded ad presented.")
  }
  
  /// Tells the delegate that the rewarded ad was dismissed.
  func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
    print("Rewarded ad dismissed.")
  }
  
  /// Tells the delegate that the rewarded ad failed to present.
  func rewardedAd(_ rewardedAd: GADRewardedAd, didFailToPresentWithError error: Error) {
    print("Rewarded ad failed to present.")
  }
}
