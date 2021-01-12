//
//  LandingViewController.swift
//  Landing
//
//  Created by lenbo lan on 2020/12/17.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    var onStart: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    @IBAction func onStartTapped(_ sender: Any) {
        onStart?()
    }
    
}

private extension LandingViewController {
    
    func setupUI() {
//        logoImageView.image = UIImage(named: "logo", in: Bundle(for: LandingViewController.self), with: nil)
        
        startButton.layer.cornerRadius = 12
        startButton.layer.masksToBounds = true
    }
    
}
