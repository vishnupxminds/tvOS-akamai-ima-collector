//
//  tvOSAkamaiIMAObserver.swift
//  tvos-akamai-IMA-collector
//
//  Created by Jijo G Oommen on 15/03/21.
//

import Foundation
import AmpIMA
import GoogleInteractiveMediaAds
import DZAkamaiTVOSCollector

class tvOSAkamaiIMAObserver : IMAAdsManagerDelegate {
    
    
    private var tvOSAkamaiIMACollector : tvOSAkamaiIMACollectorInstance
    
    private var adBufferStartTime = 0
    
    
    init(_ tvOSAkamaiIMACollector : tvOSAkamaiIMACollectorInstance) {
        self.tvOSAkamaiIMACollector = tvOSAkamaiIMACollector
        self.adBufferStartTime = 0
        
    }
    
    func adsManager(_ adsManager: IMAAdsManager!, didReceive event: IMAAdEvent!) {
        DZUtils.logPrint("IMA EVENTS \(event.typeString)")
        if let adData = event.ad {
                    let adinfo = [
                                  "adId":adData.adId,
                                  "adSystem": adData.adSystem,
                                  "advertiserName":adData.advertiserName,
                                  "creativeId":adData.creativeID,
                                  "dealId":adData.dealID,
                                  "skipTimeOffset":adData.skipTimeOffset,
                                  "wrapperCreativeIds":adData.wrapperCreativeIDs,
                                  "wrapperId": adData.wrapperAdIDs,
                                  "wrapperSystems": adData.wrapperSystems,
                                  "adTimeOffset" : adData.adPodInfo.timeOffset] as [String : Any]
                    
        
            DZUtils.logPrint("AdId :- \(adData.adId)")
    }
    }
    
    func adsManager(_ adsManager: IMAAdsManager!, didReceive error: IMAAdError!) {
        
    }
    
    func adsManagerDidRequestContentPause(_ adsManager: IMAAdsManager!) {
        
    }
    
    func adsManagerDidRequestContentResume(_ adsManager: IMAAdsManager!) {
        
    }
    
    
    func adsManagerAdDidStartBuffering(_ adsManager: IMAAdsManager!) {
        DZUtils.logPrint("AD Buffering Started")
        self.adBufferStartTime = getCurrentTs()
    }
    
    func adsManagerAdPlaybackReady(_ adsManager: IMAAdsManager!) {
        DZUtils.logPrint("AD Buffering End")
        
        if self.adBufferStartTime > 0 {
            let timeSinceAdBuffeStart = getCurrentTs() - self.adBufferStartTime
            DZUtils.logPrint("AD Buffering time :- \(timeSinceAdBuffeStart)")
            self.adBufferStartTime = 0
        }
    }
    
    
    internal func getCurrentTs() -> Int {
            let ts = Int(UInt64(floor(NSDate().timeIntervalSince1970 * 1000)))
            return ts
        }
    
}


