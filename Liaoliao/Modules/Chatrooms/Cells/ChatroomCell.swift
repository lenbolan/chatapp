//
//  ChatroomCell.swift
//  Chatrooms
//
//  Created by lenbo lan on 2021/1/11.
//

import UIKit
import RxSwift

class ChatroomCell: UITableViewCell {

    @IBOutlet weak var chatroomImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    private(set) var reuseBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reuseBag = DisposeBag()
    }
    
    func configure(usingViewModel viewModel: ChatroomViewModel) {
        self.titleLabel.text = viewModel.title
        self.chatroomImageView.image = UIImage(named: "ic-male")
        viewModel.statusMessage
            .asDriver()
            .drive(self.statusLabel.rx.text)
            .disposed(by: reuseBag)
        viewModel.timestamp
            .asDriver()
            .drive(self.timestampLabel.rx.text)
            .disposed(by: reuseBag)
    }
    
}
