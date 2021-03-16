//
//  tvOSAkamaiIMACollectorInstance.swift
//  tvos-akamai-IMA-collector
//
//  Created by Jijo G Oommen on 15/03/21.
//

import Foundation
import GoogleInteractiveMediaAds
import DZAkamaiTVOSCollector
import AmpIMA
import AmpCore


open class tvOSAkamaiIMACollectorInstance {
    
    public static let shared = tvOSAkamaiIMACollectorInstance()
    
    private var ampIMAManager: AmpIMAManager!
    private var amptvOSEventObserver :  tvOSAkamaiIMAObserver!
    
    private init() {
        
    }

    public func connect(ampIMAManager: AmpIMAManager) {
           
            self.ampIMAManager = ampIMAManager
            self.amptvOSEventObserver = tvOSAkamaiIMAObserver(self)
            self.ampIMAManager.registerImaObserver(self.amptvOSEventObserver)
        }
 
}
