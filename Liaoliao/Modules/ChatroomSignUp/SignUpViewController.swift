//
//  SignUpViewController.swift
//  ChatroomSignUp
//
//  Created by lenbo lan on 2021/1/9.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    private var presenter: Presentation!
    var presenterProducer: Presentation.Producer!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter = presenterProducer((
            email: emailTextField.rx.text.orEmpty.asDriver(),
            username: emailTextField.rx.text.orEmpty.asDriver(),
            password: emailTextField.rx.text.orEmpty.asDriver(),
            signup: signUpButton.rx.tap.asDriver()
        ))
        setupUI()
        setupBinding()
    }

}

private extension SignUpViewController {
    
    func setupUI() {
        avatarImageView.image = UIImage(named: "ic-male", in: Bundle(for: type(of: self)), with: nil)
        
        signUpButton.layer.cornerRadius = 12
        signUpButton.layer.masksToBounds = true
    }
    
    func setupBinding() {
        presenter.output.enableSignUp
//            .debug("Enble Login Driver", trimOutput: false)
            .drive(signUpButton.rx.isEnabled)
            .disposed(by: bag)
    }
    
}
