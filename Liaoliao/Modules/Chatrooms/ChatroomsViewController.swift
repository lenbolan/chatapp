//
//  ChatroomsViewController.swift
//  Chatrooms
//
//  Created by lenbo lan on 2020/12/27.
//

import UIKit

class ChatroomsViewController: UIViewController {

    private var presenter: Presentation!
    var presenterProducer: Presentation.Producer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter = presenterProducer(())
        setupUI()
        setupBinding()
    }

}

private extension ChatroomsViewController {
    
    func setupUI() {
        
    }
    
    func setupBinding() {
        
    }
    
}
