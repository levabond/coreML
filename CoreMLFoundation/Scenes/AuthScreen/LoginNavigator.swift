//
// Created by sergdort on 19/02/2017.
// Copyright (c) 2017 sergdort. All rights reserved.
//


import Foundation
import UIKit
import Domain

protocol LoginNavigator {

    func toLogin()
}

final class DefaultLoginNavigator: LoginNavigator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func toLogin() {
//        navigationController.dismiss(animated: true)
    }
}
