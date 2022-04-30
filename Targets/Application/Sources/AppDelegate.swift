import UIKit
import Utility
import Presentation
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        Assembler(container: container).apply(assemblies: [
            PresentationAssembly()
        ])
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = container.resolve(UIViewController.self, name: "LoginScene")!
        viewController.view.backgroundColor = .white
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }

}
