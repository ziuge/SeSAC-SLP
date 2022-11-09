//
//  WithHyphen+String.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/10.
//

import Foundation

extension String {
    
    func withHyphen() -> String {
        let _str = self.replacingOccurrences(of: "-", with: "") // 하이픈 모두 빼준다
        let arr = Array(_str)
        
        if arr.count > 3 {
            if let regex = try? NSRegularExpression(pattern: "([0-9]{3})([0-9]{3,4})([0-9]{4})", options: .caseInsensitive) {
                let modString = regex.stringByReplacingMatches(in: _str, options: [],
                                                               range: NSRange(_str.startIndex..., in: _str),
                                                               withTemplate: "$1-$2-$3")
                return modString
            }
        }
        
        return self
    }
}
