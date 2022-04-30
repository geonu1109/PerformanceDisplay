import UIKit
import Swinject

public struct PresentationAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(LoginViewModel.self) { resolver in
            let viewModel: LoginViewModel = .init()
            return viewModel
        }
        
        container.register(UIViewController.self, name: "LoginScene") { resolver in
            let viewController: LoginViewController = .init()
            viewController.viewModel = resolver.resolve(LoginViewModel.self)
            return viewController
        }
    }
}
