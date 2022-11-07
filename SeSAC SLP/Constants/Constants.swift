//
//  Constants.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/07.
//

import UIKit

enum Constants {
    
    enum Color {
        static let white = UIColor(red: (255/255.0), green: (255/255.0), blue: (255/255.0), alpha: 1)
        static let black = UIColor(red: (51/255.0), green: (51/255.0), blue: (51/255.0), alpha: 1)
        
        static let green = UIColor(red: 0.285, green: 0.863, blue: 0.574, alpha: 1)
        static let whiteGreen = UIColor(red: 0.804, green: 0.958, blue: 0.881, alpha: 1)
        static let yellowGreen = UIColor(red: 0.7, green: 0.921, blue: 0.381, alpha: 1)
        
        static let gray7 = UIColor(red: 0.533, green: 0.533, blue: 0.533, alpha: 1)
        static let gray6 = UIColor(red: 0.667, green: 0.667, blue: 0.667, alpha: 1)
        static let gray5 = UIColor(red: 0.742, green: 0.742, blue: 0.742, alpha: 1)
        static let gray4 = UIColor(red: 0.821, green: 0.821, blue: 0.821, alpha: 1)
        static let gray3 = UIColor(red: 0.887, green: 0.887, blue: 0.887, alpha: 1)
        static let gray2 = UIColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1)
        static let gray1 = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)

        static let success = UIColor(red: 0.384, green: 0.559, blue: 0.9, alpha: 1)
        static let error = UIColor(red: 0.913, green: 0.401, blue: 0.419, alpha: 1)
        static let focus = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    }
    
    enum Font {
        static let onboarding = UIFont(name: "NotoSansKR-Medium", size: 24)
        
        static let display1 = UIFont(name: "NotoSansKR-Regular", size: 20)
        static let display1_lineHeight = 20 * 1.6
        
        static let title1 = UIFont(name: "NotoSansKR-Medium", size: 16)
        static let title1_lineHeight = 16 * 1.6
        
        static let title2 = UIFont(name: "NotoSansKR-Regular", size: 16)
        static let title2_lineHeight = 16 * 1.6
        
        static let title3 = UIFont(name: "NotoSansKR-Medium", size: 14)
        static let title3_lineHeight = 14 * 1.6
        
        static let title4 = UIFont(name: "NotoSansKR-Regular", size: 14)
        static let title4_lineHeight = 14 * 1.6
        
        static let title5 = UIFont(name: "NotoSansKR-Medium", size: 12)
        static let title5_lineHeight = 12 * 1.5
        
        static let title6 = UIFont(name: "NotoSansKR-Regular", size: 12)
        static let title6_lineHeight = 12 * 1.5
        
        static let body1 = UIFont(name: "NotoSansKR-Medium", size: 16)
        static let body1_lineHeight = 16 * 1.85
        
        static let body2 = UIFont(name: "NotoSansKR-Regular", size: 16)
        static let body2_lineHeight = 16 * 1.85
        
        static let body3 = UIFont(name: "NotoSansKR-Regular", size: 14)
        static let body3_lineHeight = 14 * 1.7
        
        static let body4 = UIFont(name: "NotoSansKR-Regular", size: 12)
        static let body4_lineHeight = 12 * 1.80
        
        static let caption = UIFont(name: "NotoSansKR-Regular", size: 10)
        static let caption_lineHeight = 10 * 1.6
    }
}
