import Foundation
import Domain
import NetworkPlatform
import CoreDataPlatform
import RealmPlatform

final class Application {
    static let shared = Application()

    private let coreDataUseCaseProvider: Domain.UseCaseProvider
    private let realmUseCaseProvider: Domain.UseCaseProvider
    private let networkUseCaseProvider: Domain.UseCaseProvider

    private init() {
        self.coreDataUseCaseProvider = CoreDataPlatform.UseCaseProvider()
        self.realmUseCaseProvider = RealmPlatform.UseCaseProvider()
        self.networkUseCaseProvider = NetworkPlatform.UseCaseProvider()
    }

    func configureMainInterface(in window: UIWindow) {
        window.backgroundColor = .black
        let homeScreen = DefaultHomeNavigator(window: window)
        homeScreen.toHome()
        
        MainTheme.UIConfigurate()
    }
}
