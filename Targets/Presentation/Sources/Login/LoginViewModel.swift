import RxCocoa

final class LoginViewModel {
    private let navigationRelay: PublishRelay<LoginNavigation> = .init()
    var navigationSignal: Signal<LoginNavigation> {
        return navigationRelay.asSignal()
    }
    
    func clickLoginButton() {
        navigationRelay.accept(.preformanceDisplayList)
    }
}
