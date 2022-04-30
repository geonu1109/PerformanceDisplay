import UIKit
import RxSwift
import SnapKit

final class LoginViewController: UIViewController {
    var viewModel: LoginViewModel? {
        didSet {
            viewModelBinding = viewModel.map(bind(to:))
        }
    }
    
    let loginButton: UIButton = {
        let button: UIButton = .init(type: .custom)
        button.setTitle("로그인", for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        
        return button
    }()
    
    private var viewModelBinding: Disposable? = nil {
        willSet {
            viewModelBinding?.dispose()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.snp.makeConstraints { maker in
            maker.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            maker.right.equalTo(view.safeAreaLayoutGuide).offset(20)
            maker.centerY.equalTo(view.safeAreaLayoutGuide)
            maker.height.equalTo(80)
        }
    }
    
    private func bind(to viewModel: LoginViewModel) -> Disposable {
        return Disposables.create([
            loginButton.rx.tap
                .bind(with: viewModel, onNext: { viewModel, _ in
                    viewModel.clickLoginButton()
                }),
            viewModel.navigationSignal
                .emit(with: self, onNext: { viewController, navigation in
                    
                })
        ])
    }
    
    private func navigate(to navigation: LoginNavigation) {
        switch navigation {
        case .preformanceDisplayList:
            // TODO: implement
            break
        }
    }
    
    deinit {
        viewModelBinding?.dispose()
    }
}
