//
//  TrackDateFormatter.swift
//  Rock-Tracks
//
//  Created by Rufus on 13/01/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import Foundation

public class TrackDateFormatter {
    let dateFormatter = DateFormatter.iso8601DateFormatter
    
    public init(){
        dateFormatter.dateFormat = "dd-MM-yyyy"
    }
    
    open func getFormattedDate(iso8601: String) -> String? {
        if let date = DateFormatter.date(fromISO8601String: iso8601){
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate
        }
        return nil
    }
}

extension DateFormatter {
    
    static let iso8601DateFormatter: DateFormatter = {
        let enUSPOSIXLocale = Locale(identifier: "en_US_POSIX")
        let iso8601DateFormatter = DateFormatter()
        iso8601DateFormatter.locale = enUSPOSIXLocale
        iso8601DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        iso8601DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return iso8601DateFormatter
    }()
    
    static let iso8601WithoutMillisecondsDateFormatter: DateFormatter = {
        let enUSPOSIXLocale = Locale(identifier: "en_US_POSIX")
        let iso8601DateFormatter = DateFormatter()
        iso8601DateFormatter.locale = enUSPOSIXLocale
        iso8601DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        iso8601DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return iso8601DateFormatter
    }()
    
    static func date(fromISO8601String string: String) -> Date? {
        if let dateWithMilliseconds = iso8601DateFormatter.date(from: string) {
            return dateWithMilliseconds
        }
        
        if let dateWithoutMilliseconds = iso8601WithoutMillisecondsDateFormatter.date(from: string) {
            return dateWithoutMilliseconds
        }
        
        return nil
    }
}
