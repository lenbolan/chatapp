//
//  ProfileViewController.swift
//  Profile
//
//  Created by lenbo lan on 2020/12/27.
//

import UIKit

class ProfileViewController: UIViewController {

    private var presenter: Presentation!
    var presenterProducer: Presentation.Producer!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter = presenterProducer(())
        setupUI()
    }

}

private extension ProfileViewController {
    
    func setupUI() {
        profileImageView.image = UIImage(named: "ic-male")
    }
    
}
