//
//  MainTheme.swift
//  CoreMLFoundation
//
//  Created by Лев Бондаренко on 15.03.2020.
//  Copyright © 2020 sergdort. All rights reserved.
//

import UIKit

struct MainTheme {
    static var backgroundColor = UIColor(hexString: "#2b2b2b")
    static var blackColor = UIColor(hexString: "#1e1e1e")
    static var accentColor = UIColor(hexString: "#d93874")
    static var accent2Color = UIColor(hexString: "#e8816b")
    static var textColor = UIColor(hexString: "#bdbdbd")
    static var purpure = UIColor(hexString: "#302f5b")
    
    static func UIConfigurate() {
        let navbar = UINavigationBar.appearance()
        navbar.barTintColor = backgroundColor
        navbar.isTranslucent = false
        navbar.isOpaque = false
        navbar.titleTextAttributes = [
            .foregroundColor: accentColor,
            .font: UIFont.systemFont(ofSize: 17, weight: .semibold)
        ]
        
        let label = UILabel.appearance()
        label.textColor = textColor
    }
}
