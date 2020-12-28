//
//  ChatroomLoginViewController.swift
//  ChatroomLogin
//
//  Created by lenbo lan on 2020/12/18.
//

import UIKit
import RxSwift
import RxCocoa

protocol Presentation {
    
    typealias Input = (
        email: Driver<String>,
        password: Driver<String>,
        login: Driver<Void>
    )
    typealias Output = (
        enableLogin: Driver<Bool>, ()
    )
    typealias Producer = (Presentation.Input) -> Presentation
    
    var input: Input { get }
    var output: Output { get }
    
}

class ChatroomLoginViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private var presenter: Presentation!
    var presenterProducer: Presentation.Producer!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = presenterProducer((
            email: emailTextField.rx.text.orEmpty.asDriver(),
            password: passwordTextField.rx.text.orEmpty.asDriver(),
            login: loginButton.rx.tap.asDriver()
        ))
        setupUI()
        setupBinding()
    }

}

private extension ChatroomLoginViewController {
    
    func setupUI() {
        avatarImageView.image = UIImage(named: "ic-female", in: Bundle(for: ChatroomLoginViewController.self), with: nil)
        
        loginButton.layer.cornerRadius = 12
        loginButton.layer.masksToBounds = true
    }
    
    func setupBinding() {
        presenter.output.enableLogin
//            .debug("Enble Login Driver", trimOutput: false)
            .drive(loginButton.rx.isEnabled)
            .disposed(by: bag)
    }
    
}
