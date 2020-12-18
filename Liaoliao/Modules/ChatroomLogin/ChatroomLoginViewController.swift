//
//  ChatroomLoginViewController.swift
//  ChatroomLogin
//
//  Created by lenbo lan on 2020/12/18.
//

import UIKit

class ChatroomLoginViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

}

private extension ChatroomLoginViewController {
    
    func setupUI() {
        avatarImageView.image = UIImage(named: "ic-female", in: Bundle(for: ChatroomLoginViewController.self), with: nil)
        
        loginButton.layer.cornerRadius = 12
        loginButton.layer.masksToBounds = true
    }
}
