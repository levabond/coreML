//
// Created by sergdort on 19/02/2017.
// Copyright (c) 2017 sergdort. All rights reserved.
//


import Foundation
import UIKit
import Domain

protocol HomeNavigator {

    func toHome()
}

final class DefaultHomeNavigator: HomeNavigator {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func toHome() {
        window.makeKeyAndVisible()
//        window.hero.id = "test 1"
        let vc = HomeScreenViewController()
//        vc.hero.isEnabled = true
//        vc.tableView.hero.id = "test 1"
        
        window.rootViewController = UINavigationController(rootViewController: vc)
    }
}
