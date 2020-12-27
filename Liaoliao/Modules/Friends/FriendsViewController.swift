//
//  FriendsViewController.swift
//  Friends
//
//  Created by lenbo lan on 2020/12/27.
//

import UIKit

import EmptyView

class FriendsViewController: UIViewController {

    private var presenter: Presentation!
    var presenterProducer: Presentation.Producer!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter = presenterProducer(())
        setupUI()
    }

}

private extension FriendsViewController {
    
    func setupUI() {
        let emptyImage = UIImage(systemName: "person.icloud.fill")!
        let emptyView = EmptyView(frame: .zero)
        emptyView.configure(image: emptyImage, title: "Sigh!", subtitle: "No friend has joined yet")
        tableView.backgroundView = emptyView
    }
    
}
