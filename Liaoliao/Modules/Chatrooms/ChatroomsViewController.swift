//
//  ChatroomsViewController.swift
//  Chatrooms
//
//  Created by lenbo lan on 2020/12/27.
//

import UIKit

import Utility
import EmptyView

class ChatroomsViewController: UIViewController {

    private var presenter: Presentation!
    var presenterProducer: Presentation.Producer!
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var createChatroomButton: UIButton = {
        let button = UIButton(type: .custom) as UIButton
        
        let yPosition = self.view.frame.height - 180
        let xPosition = self.view.frame.width - 100
        let createImage = UIImage(systemName: "plus.bubble")?.scaleImage(scaleSize: 4.0).withTintColor(.deepPurple)
        button.setImage(createImage, for: .normal)
        button.tintColor = .deepPurple
        button.frame = CGRect(x: xPosition, y: yPosition, width: 60, height: 60)
        button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        button.layer.zPosition = 1
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter = presenterProducer(())
        setupUI()
        setupBinding()
    }

}

private extension ChatroomsViewController {
    
    func setupUI() {
        self.view.addSubview(createChatroomButton)
        
        let emptyImage = UIImage(systemName: "waveform")!
        let emptyView = EmptyView(frame: .zero)
        emptyView.configure(image: emptyImage, title: "Oops", subtitle: "Looks like there are no chatrooms")
        tableView.backgroundView = emptyView
    }
    
    func setupBinding() {
        
    }
    
}
