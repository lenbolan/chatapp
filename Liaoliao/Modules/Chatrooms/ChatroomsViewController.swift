//
//  ChatroomsViewController.swift
//  Chatrooms
//
//  Created by lenbo lan on 2020/12/27.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

import Utility
import EmptyView

class ChatroomsViewController: UIViewController {

    private var presenter: Presentation!
    var presenterProducer: Presentation.Producer!
    
    @IBOutlet weak var tableView: UITableView!
    
    private let bag = DisposeBag()
    
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
    
    private lazy var emptyView: EmptyView = {
        let emptyImage = UIImage(systemName: "waveform")!
        let emptyView = EmptyView(frame: .zero)
        emptyView.configure(image: emptyImage, title: "Uh Ho", subtitle: "Looks like there are no chatroom")
        return emptyView
    }()
    
    private lazy var datasource = RxTableViewSectionedReloadDataSource<ChatroomsSection> { (_, tableView, indexPath, item) in
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChatroomCell.self), for: indexPath) as? ChatroomCell else {
            return UITableViewCell()
        }
        cell.configure(usingViewModel: item)
        return cell
    }
    
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
        
        let chatroomCellNib = UINib(nibName: "ChatroomCell", bundle: Bundle(for: ChatroomCell.self))
        tableView.register(chatroomCellNib, forCellReuseIdentifier: String(describing: ChatroomCell.self))
    }
    
    func setupBinding() {
        self.presenter.output.sections
            .drive(self.tableView.rx.items(dataSource: datasource))
            .disposed(by: bag)
        
        self.presenter.output.sections
            .map({ $0.first! })
            .map({ $0.items.count > 0 })
            .map({ [tableView, emptyView] in
                tableView?.backgroundView = $0 ? nil : emptyView
            })
            .drive()
            .disposed(by: bag)
    }
    
}
