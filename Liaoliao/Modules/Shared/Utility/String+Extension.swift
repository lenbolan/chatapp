//
//  String+Extension.swift
//  Utility
//
//  Created by lenbo lan on 2020/12/19.
//

import Foundation

public extension String {
    
    func isEmail() -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pattern = NSPredicate(format: "SELF MATCHES %@", regex)
        return pattern.evaluate(with: self)
    }
    
    func converToDate() -> Date? {
        let createDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let dateFromStringFormatter = DateFormatter()
        dateFromStringFormatter.dateFormat = createDateFormat
        return dateFromStringFormatter.date(from: self)
    }
    
}
