//
//  CreateChatroomViewController.swift
//  CreateChatroom
//
//  Created by lenbo lan on 2021/1/22.
//

import UIKit
import RxSwift
import RxCocoa

class CreateChatroomViewController: UIViewController {
    
    @IBOutlet weak var groupAvatarImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var subjectTextField: UITextView!

    private var presenter: Presentation!
    var presenterProducer: Presentation.Producer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter = presenterProducer((
            chatroomName: self.titleTextField.rx.text.orEmpty.asDriver(),
            chatroomSubject: self.subjectTextField.rx.text.orEmpty.asDriver()
        ))
        setupUI()
        setupBinding()
    }

}

private extension CreateChatroomViewController {
    
    func setupUI() {
        
    }
    
    func setupBinding() {
        
    }
    
}
