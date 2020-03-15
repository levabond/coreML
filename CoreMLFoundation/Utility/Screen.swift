//
//  Screen.swift
//  CoreMLFoundation
//
//  Created by Лев Бондаренко on 15.03.2020.
//  Copyright © 2020 sergdort. All rights reserved.
//

import UIKit

public struct Screen {
    static var width: CGFloat {
        get {
            return UIScreen.main.bounds.width
        }
    }
    
    static var height: CGFloat {
        get {
            return UIScreen.main.bounds.height
        }
    }
}
