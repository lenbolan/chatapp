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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter = presenterProducer(())
    }

}
