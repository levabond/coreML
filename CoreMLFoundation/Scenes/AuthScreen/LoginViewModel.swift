//
// Created by sergdort on 19/02/2017.
// Copyright (c) 2017 sergdort. All rights reserved.
//


import Foundation
import RxSwift
import RxCocoa
import Domain

final class LoginViewModel: ViewModelType {
    func transform(input: LoginViewModel.Input) -> LoginViewModel.Output {
        return Output()
    }
    
    init() {}
}

extension LoginViewModel {
    struct Input {
    }

    struct Output {
    }
}
