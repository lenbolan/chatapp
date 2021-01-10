//
//  ProfileViewController.swift
//  Profile
//
//  Created by lenbo lan on 2020/12/27.
//

import UIKit
import RxSwift

class ProfileViewController: UIViewController {

    private var presenter: Presentation!
    var presenterProducer: Presentation.Producer!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter = presenterProducer(())
        setupUI()
        setupBinding()
    }

}

private extension ProfileViewController {
    
    func setupUI() {
        profileImageView.image = UIImage(named: "ic-male")
    }
    
    func setupBinding() {
        presenter.output.username
            .drive(self.usernameLabel.rx.text)
            .disposed(by: bag)
        
        presenter.output.email
            .drive(self.emailLabel.rx.text)
            .disposed(by: bag)
    }
    
}
