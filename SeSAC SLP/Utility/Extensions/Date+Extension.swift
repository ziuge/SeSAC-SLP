//
//  Date+Extension.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/12/20.
//

import UIKit

extension UIViewController {
    func stringToDate(string: String) -> Date {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        let date = formatter.date(from: string) ?? Date()
        return date
    }
    
    func dateToTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let string = formatter.string(from: date)
        return string
    }
}
