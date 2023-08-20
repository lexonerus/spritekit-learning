//
//  AdMobHelper.swift
//  gloopdrop
//
//  Created by Tammy Coron on 1/24/2020.
//  Copyright © 2020 Just Write Code LLC. All rights reserved.
//

import Foundation
import GoogleMobileAds

struct AdMobHelper {
  static let bannerAdDisplayTime: TimeInterval = 30
  static let bannerAdID = "ca-app-pub-3940256099942544/2934735716" // test id
  
  static var rewardAdReady = false
  static let rewardAdID = "ca-app-pub-3940256099942544/1712485313" // test
}

fileprivate var _adBannerView = GADBannerView(adSize: kGADAdSizeBanner)
fileprivate var _rewardedAd: GADRewardedAd?

extension GameViewController {
  // MARK: - Properties
  var adBannerView: GADBannerView {
    get {
      return _adBannerView
    }
    set(newValue) {
      _adBannerView = newValue
    }
  }
  
  var rewardedAd: GADRewardedAd? {
      get {
        return _rewardedAd
      }
      set(newValue) {
          _rewardedAd = newValue
      }
  }
  
  // Set up Banner Ads
  func setupBannerAdsWith(id: String) {
    
    // Set up the banner ads and the banner view
    adBannerView.adUnitID = id
    adBannerView.delegate = self
    adBannerView.rootViewController = self
    
    // Add the banner view to the view
    addBannerViewToView(adBannerView)
    
    // Start serving ads
    startServingAds(after: AdMobHelper.bannerAdDisplayTime)
  }
  
  // Add the ad banner to the view
  func addBannerViewToView(_ bannerView: GADBannerView) {
    bannerView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(bannerView)
    NSLayoutConstraint.activate([
      bannerView.topAnchor.constraint(equalTo: view.topAnchor),
      bannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
  }
  
  // Start serving ads using a scheduled timer
  func startServingAds(after seconds: TimeInterval) {
    // Start serving banner ads after XX seconds
    Timer.scheduledTimer(timeInterval: seconds, target: self,
                         selector: #selector(requestAds(_:)),
                         userInfo: adBannerView, repeats: false)
  }
  
  // Start serving banner ads
  @objc func requestAds(_ timer: Timer) {
    let bannerView = timer.userInfo as? GADBannerView
    let request = GADRequest()
    bannerView?.load(request)
    
    timer.invalidate()
  }
  
  // Hide banner
  @objc func hideBanner(_ timer: Timer) {
    let bannerView = timer.userInfo as! GADBannerView
    UIView.animate(withDuration: 0.5) {
      bannerView.alpha = 0.0
    }
    
    timer.invalidate()
  }
  
  // Set up Rewarded Ads
  func setupRewardAdsWith(id: String) {
    AdMobHelper.rewardAdReady = false // reset the ready flag
    
    rewardedAd = GADRewardedAd(adUnitID: id)
    rewardedAd?.load(GADRequest()) { error in
      if let error = error {
        print("*********************** \(error.localizedDescription)")
      } else {
        print("*********************** Reward Ad Loaded OK!")
        AdMobHelper.rewardAdReady = true
      }
    }
  }
}

// MARK: - DELEGATE EXTENSIONS

/* ############################################################ */
/*             ADMOB DELEGATE FUNCTIONS STARTS HERE             */
/* ############################################################ */

extension GameViewController : GADBannerViewDelegate {
  
  // MARK: - GADBannerViewDelegate: Ad Request Lifecycle Notifications
  
  /// Tells the delegate an ad request loaded an ad.
  func adViewDidReceiveAd(_ bannerView: GADBannerView) {
    print("adViewDidReceiveAd")
    
    adBannerView = bannerView
    UIView.animate(withDuration: 0.5,
                   animations: {[weak self] in self?.adBannerView.alpha = 1.0})
             
    // Auto-hide banner
    Timer.scheduledTimer(timeInterval: AdMobHelper.bannerAdDisplayTime,
                         target: self,
                         selector: #selector(hideBanner(_:)),
                         userInfo: bannerView, repeats: false)
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
    NotificationCenter.default.post(name: .adDidOrWillPresent, object: nil)
  }
  
  /// Tells the delegate that the full-screen view will be dismissed.
  func adViewWillDismissScreen(_ bannerView: GADBannerView) {
    print("adViewWillDismissScreen")
    NotificationCenter.default.post(name: .adDidOrWillDismiss, object: nil)
  }
  
  /// Tells the delegate that the full-screen view has been dismissed.
  func adViewDidDismissScreen(_ bannerView: GADBannerView) {
    print("adViewDidDismissScreen")
    NotificationCenter.default.post(name: .adDidOrWillDismiss, object: nil)
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
  func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn
    reward: GADAdReward) {
    print("Reward received: \(reward.type) | amount: \(reward.amount).")
    NotificationCenter.default.post(name: .userDidEarnReward, object: reward)
  }
  
  /// Tells the delegate that the rewarded ad was presented.
  func rewardedAdDidPresent(_ rewardedAd: GADRewardedAd) {
    print("Rewarded ad presented.")
    NotificationCenter.default.post(name: .adDidOrWillPresent, object: nil)
  }
  
  /// Tells the delegate that the rewarded ad was dismissed.
  func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
    print("Rewarded ad dismissed.")
    setupRewardAdsWith(id: AdMobHelper.rewardAdID)
    NotificationCenter.default.post(name: .adDidOrWillDismiss, object: nil)
  }
  
  /// Tells the delegate that the rewarded ad failed to present.
  func rewardedAd(_ rewardedAd: GADRewardedAd, didFailToPresentWithError error: Error) {
    print("Rewarded ad failed to present.")
  }
}

extension Notification.Name {
  static let userDidEarnReward = Notification.Name("userDidEarnReward")
  static let adDidOrWillPresent = Notification.Name("adDidOrWillPresent")
  static let adDidOrWillDismiss = Notification.Name("adDidOrWillDismiss")
}

extension GameScene {
  func setupAdMobObservers() {
    // Add notification observers
    NotificationCenter.default.addObserver(self,
                                     selector:
                                     #selector(self.userDidEarnReward(_:)),
                                     name: .userDidEarnReward, object: nil)
    
    NotificationCenter.default.addObserver(self,
                                     selector:
                                     #selector(self.adDidOrWillPresent),
                                     name: .adDidOrWillPresent, object: nil)
    
    NotificationCenter.default.addObserver(self,
                                     selector:
                                     #selector(self.adDidOrWillDismiss),
                                     name: .adDidOrWillDismiss, object: nil)
  }
  
  @objc func userDidEarnReward(_ reward: GADAdReward) {
    numberOfFreeContinues += 1
  }
  
  @objc func adDidOrWillPresent() {
    audioEngine.mainMixerNode.outputVolume = 0.0
    watchAdButton.alpha = 0.0
  }
  
  @objc func adDidOrWillDismiss() {
    audioEngine.mainMixerNode.outputVolume = 1.0
  }
}
