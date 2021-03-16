//
//  DZUtils.swift
//  DZAkamaiTVOSCollector
//
//  Created by Vinu Varghese on 22/06/20.
//  Copyright © 2020 Datazoom. All rights reserved.
//

import Foundation
import AdSupport
import DzTvOSBase

public class DZUtils {
    private static let LAST_EVENT_SENT_AT: String = "_last_event_sent_at"

    private static let KEY_SESSION_ID: String = "SessionID"

    private static let SESSION_GENERATED_AT: String = "DZ_Session_CreatedAt"

    private static let SESSSION_VIEW_ID: String = "DZ_SESSION_VIEW_ID"

    private static let KEY_SOCKET_SESSION_ID: String = "DZ_SOCKET_SESSION_ID"
    
    private static let KEY_OFFSET_MILLIS: String = "DZ_CLIENT_OFFSET_MILLIS"

    // Session duration is 20 mins (20 * 60) seconds
    private static let SESSION_DURATION: Double = 20 * 60

    private init() {

    }

    private static let dateFormatter: DateFormatter = {
        let _dateFormatter = DateFormatter()
        _dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss.SSSxxx"
        return _dateFormatter
    }()

    /// MARK: - Get Session ID
    public static func getSessionID() -> String {
        let currentTime = Date()
        let lastEventSentAt = getLastMessageSentAt()
        let sessionExpiresAt = lastEventSentAt.addingTimeInterval(SESSION_DURATION)

        logPrint("Last event sent at: \(lastEventSentAt)")
        logPrint("Session expires at: \(sessionExpiresAt)")
        logPrint("Current time: \(currentTime)")

        if (currentTime > sessionExpiresAt) {
            generateSessionID()
        }
        var sidStr = UserDefaults.standard.string(forKey: KEY_SESSION_ID)
        if sidStr == nil {
            sidStr = generateSessionID()
        }
        return sidStr!
    }

    public static func getSessionViewId() -> String {
        let viewIds = UserDefaults.standard.dictionary(forKey: SESSSION_VIEW_ID) ?? [:]
        let sessionId = getSessionID()
        if viewIds[sessionId] == nil {
            return "NA"
        }
        return "\(sessionId)-\(viewIds[sessionId] as! Int)"
    }

    public static func nextViewId() -> String {
        let sessionId = getSessionID()
        var viewIds = UserDefaults.standard.dictionary(forKey: SESSSION_VIEW_ID) ?? [:]
        if viewIds[sessionId] == nil {
            viewIds[sessionId] = 1
        } else {
            viewIds[sessionId] = viewIds[sessionId] as! Int + 1
        }
        UserDefaults.standard.set(viewIds, forKey: SESSSION_VIEW_ID)
        return "\(sessionId)-\(viewIds[sessionId] as! Int)"
    }

    public static func logPrint(_ message: String) {
        let dateString = dateFormatter.string(from: Date())
        print("DZ-LOG [\(dateString)]: \(message)")
    }

    public static func getSessionCreatedAt() -> Int {
        return UserDefaults.standard.integer(forKey: SESSION_GENERATED_AT)
    }

    /// MARK: - Generate Session ID
    internal static func generateSessionID() -> String {
        var s_sessionId: String = String()
        let sid = UUID().uuidString.lowercased()
        let sidStr = base64Encode(strVal: sid)
        s_sessionId = sidStr
        UserDefaults.standard.set(s_sessionId, forKey: KEY_SESSION_ID)
        UserDefaults.standard.set(DZUtils.getCurrentTimeStamp(), forKey: SESSION_GENERATED_AT)
        logPrint("Generated sessionid: \(s_sessionId)")
        messageSent()
//        DZTvOsBaseCollector.shared.setEngagementStartAt()
//        DZTvOsBaseCollector.shared.resetAppInactiveAt()
//        DZTvOsBaseCollector.shared.resetAppInactiveDuration()
//        DZTvOsBaseCollector.shared.resetTotalPlaybackDurationAds()
//        DZEventManager.shared.resetViewIdGenerated()
        return s_sessionId
    }

    ///MARK: - Base64 encode
    internal static func base64Encode(strVal: String) -> String {
        let utf8str = strVal.data(using: String.Encoding.utf8)
        let base64Encoded = utf8str?.base64EncodedString()
        return base64Encoded!
    }

    ///MARK: - Random Generate Number
    internal static func random(_ range: Range<Int>) -> Int {
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
    }

    internal static func messageSent() -> Date {
        let timeNow = Date()
        UserDefaults.standard.set(timeNow, forKey: LAST_EVENT_SENT_AT)
        return timeNow
    }

    internal static func getLastMessageSentAt() -> Date {
        let lastMessageSentAt: Date? = UserDefaults.standard.object(forKey: LAST_EVENT_SENT_AT) as? Date
        return lastMessageSentAt ?? messageSent()
    }

    internal static func cleanHash(items: Dictionary<String, Any>, keysToInclude: [String]) -> Dictionary<String, Any> {
        var itemsLocal = items
        for itemKey in itemsLocal.keys {
            if keysToInclude.firstIndex(of: itemKey) == nil {
                itemsLocal.remove(at: itemsLocal.index(forKey: itemKey)!)
            }
        }
        return itemsLocal
    }

    public static func getCurrentTimeStamp() -> Int {
        let ts = Int(UInt64(floor(NSDate().timeIntervalSince1970 * 1000)))
        return ts
    }
    
    internal static func saveClientOffSetMillis(_ offSetMillis: Int) {
        UserDefaults.standard.set(offSetMillis, forKey: KEY_OFFSET_MILLIS)
    }
    
    internal static func getClientOffSetMillis() -> Int {
        return UserDefaults.standard.integer(forKey: KEY_OFFSET_MILLIS)
    }

    //MARK:- Get Identifier For Advertising
    static func identifierForAdvertising() -> String? {
        // Check whether advertising tracking is enabled
        guard ASIdentifierManager.shared().isAdvertisingTrackingEnabled else {
            return nil
        }

        // Get and return IDFA
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }


    private
    static func stripFileExtension(_ filename: String) -> String {
        var components = filename.components(separatedBy: ".")
        guard components.count > 1 else {
            return filename
        }
        components.removeLast()
        return components.joined(separator: ".")
    }

    internal static func nameOfApp() -> String {
        let bundle = Bundle.main
        if let name = bundle.object(forInfoDictionaryKey: "CFBundleDisplayName")
                ?? bundle.object(forInfoDictionaryKey: kCFBundleNameKey as String),
           let stringName = name as? String {
            return stringName
        }

        let bundleURL = bundle.bundleURL
        let filename = bundleURL.lastPathComponent
        return stripFileExtension(filename)
    }

    internal static func getSocketSessionId() -> String {
        let scoketSessionId = UserDefaults.standard.string(forKey: KEY_SOCKET_SESSION_ID)
        return scoketSessionId ?? ""
    }

    internal static func roundDoubleValue(_ num: Double) -> NSDecimalNumber {
        let scale: Int16 = 3
        let behavior = NSDecimalNumberHandler(roundingMode: .plain, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
        return NSDecimalNumber(value: num).rounding(accordingToBehavior: behavior)
    }
    
    internal static func roundDoubleValuePrecison4(_ num: Double) -> NSDecimalNumber {
        let scale: Int16 = 4
        let behavior = NSDecimalNumberHandler(roundingMode: .plain, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
        return NSDecimalNumber(value: num).rounding(accordingToBehavior: behavior)
    }
}
