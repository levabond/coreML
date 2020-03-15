//
//  UIImage + Ext.swift
//  CoreMLFoundation
//
//  Created by Лев Бондаренко on 15.03.2020.
//  Copyright © 2020 sergdort. All rights reserved.
//

import UIKit

extension UIImage {
    static func getImage(urlString: String) -> UIImage? {
        guard let imageUrl = URL(string: urlString) else { return nil }

        if let data = try? Data(contentsOf: imageUrl) {
            return UIImage(data: data)
        }

        return nil
    }
}
