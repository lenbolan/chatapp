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
    
    private let subjectPlaceholder = "Enter chatroom subject..."
    
    private let bag = DisposeBag()
    
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
            chatroomSubject: self.subjectTextField.rx
                .text
                .orEmpty
                .map({ [subjectPlaceholder] in
                    guard $0 != subjectPlaceholder else { return "" }
                    return $0
                })
                .asDriver(onErrorDriveWith: .never())
        ))
        setupUI()
        setupBinding()
    }

}

private extension CreateChatroomViewController {
    
    func setupUI() {
        groupAvatarImageView.image = UIImage(named: "ic-group")
        
        createButton.layer.cornerRadius = 12
        createButton.layer.masksToBounds = true
        
        subjectTextField.text = subjectPlaceholder
        subjectTextField.textColor = .lightGray
    }
    
    func setupBinding() {
        subjectTextField.rx.didBeginEditing
            .asDriver()
            .withLatestFrom(subjectTextField.rx.text.asDriver())
            .filter({ [subjectPlaceholder] in $0 ?? "" == subjectPlaceholder })
            .map({ [subjectTextField] _ in
                subjectTextField?.text = ""
                subjectTextField?.textColor = .black
            })
            .drive()
            .disposed(by: bag)
        
        ControlEvent.merge(subjectTextField.rx.didEndEditing.map({ _ in () }),
                           subjectTextField.rx.didChange.map({ _ in () }))
            .asDriver(onErrorDriveWith: .never())
            .map(resetTextView)
            .drive()
            .disposed(by: bag)
        
        self.presenter.output.enableCreate
            .drive(self.createButton.rx.isEnabled)
            .disposed(by: bag)
    }
    
}

private extension CreateChatroomViewController {
    
    func resetTextView() {
        if subjectTextField.text.count == 0 {
            subjectTextField.text = subjectPlaceholder
            subjectTextField.textColor = .lightGray
            subjectTextField.resignFirstResponder()
        }
    }
    
}
