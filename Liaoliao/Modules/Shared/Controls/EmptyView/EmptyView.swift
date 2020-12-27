//
//  EmptyView.swift
//  EmptyView
//
//  Created by lenbo lan on 2020/12/27.
//

import UIKit

public final class EmptyView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var emptyImageView: UIImageView!
    @IBOutlet weak var emptyTitle: UILabel!
    @IBOutlet weak var emptySubtitle: UILabel!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        Bundle(for: type(of: self)).loadNibNamed("EmptyView", owner: self, options: nil)
        backgroundColor = .clear
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    public func configure(image: UIImage, title: String, subtitle: String) {
        self.emptyImageView.image = image
        self.emptyTitle.text = title
        self.emptySubtitle.text = subtitle
    }
    
}
