//
//  AppConstants.swift
//  MoneyPlus
//
//  Created by FakeCoder on 2020/10/11.
//

import Foundation
import UIKit

struct AppConstants {
    // String
    static var bundleID = "site.waitforaday.MoneyPlus"
    
    // Font
    static var kTitleFont: UIFont = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
    
    // Float
    static var kScreenWidth = UIScreen.main.bounds.size.width
    static var kScreenHeight = UIScreen.main.bounds.size.height
    static var kCornerRadius: CGFloat = 16
    static var kTextFieldCornerRadius: CGFloat = 8
    static var kTextFieldHeight: CGFloat = 50
    static var kViewMargin: CGFloat = 12

    // Color
    static var kWhiteColor = UIColor.white
    static var kBlackColor = UIColor.black
    static var kLightGrayColor = UIColor.lightGray

    static let incomeColor = UIColor.init(red: 241/255, green: 172/255, blue: 69/255, alpha: 1)
    static var kIncomeColor = getDarkModeSupportedColor(lightColor: incomeColor, darkColor: UIColor.black)
    static var kIncomeTitleColor = getDarkModeSupportedColor(lightColor: UIColor.white, darkColor: incomeColor)
    
    static let totalBalanceColor = UIColor.init(red: 74/255, green: 88/255, blue: 235/255, alpha: 1)
    static var kTotalBalanceColor = getDarkModeSupportedColor(lightColor: totalBalanceColor, darkColor: UIColor.black)
    static var kTotalBalanceTitleColor = getDarkModeSupportedColor(lightColor: UIColor.white, darkColor: totalBalanceColor)

    static let expenseColor = UIColor.init(red: 233/255, green: 69/255, blue: 90/255, alpha: 1)
    static var kExpenseColor = getDarkModeSupportedColor(lightColor: expenseColor, darkColor: UIColor.black)
    static var kExpenseTitleColor = getDarkModeSupportedColor(lightColor: UIColor.white, darkColor: expenseColor)
    
    static var kBackgroudColor = getDarkModeSupportedColor(lightColor: UIColor.white, darkColor: UIColor.black)
    static var kAntiBackgroudColor = getDarkModeSupportedColor(lightColor: UIColor.black, darkColor: UIColor.white)
}

func getDarkModeSupportedColor(lightColor: UIColor, darkColor: UIColor) -> UIColor {
    if #available(iOS 13, *) {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return darkColor
            } else {
                return lightColor
            }
        }
    } else {
        return lightColor
    }
}
