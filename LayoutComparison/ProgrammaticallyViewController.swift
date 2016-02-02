//
//  ProgrammaticallyViewController.swift
//  LayoutComparison
//
//  Created by Ryohei Kameyama on 2016/02/02.
//  Copyright © 2016年 codingcafe.jp. All rights reserved.
//

import UIKit

private func cellClassForRepository(item: Repository) -> AnyClass {
    
    switch cellIdentifierForRepository(item) {
    case "Big": return PBigCell.self
    case "Normal": return PNormalCell.self
    default: fatalError()
    }
}

private let kIconWidth: CGFloat = 48
private let kMargin: CGFloat = 8

protocol HeightCalculable {
    static func sizeThatFits(size: CGSize, repository: Repository) -> CGSize
}

class PBaseCell: UITableViewCell, CellRepositorySupport {
    let iconImageView: UIImageView! = UIImageView()
    let textView: UITextView! = UITextView()
    
    dynamic var textFont: UIFont = UIFont.systemFontOfSize(UIFont.systemFontSize()) {
        didSet {
            textView.font = textFont
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textView.contentInset = UIEdgeInsetsZero
        textView.textContainerInset = UIEdgeInsetsZero
        textView.textContainer.lineFragmentPadding = 0
        textView.editable = false
        textView.selectable = false
        textView.scrollEnabled = false
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(textView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class PNormalCell: PBaseCell, HeightCalculable {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w = CGRectGetWidth(bounds)
        
        iconImageView.frame = CGRect(
            x: kMargin,
            y: kMargin,
            width: kIconWidth,
            height: kIconWidth)
        
        let textWidth = w - kMargin * 2.0 - kIconWidth
        
        textView.frame = CGRect(
            x: kIconWidth + kMargin * 2.0,
            y: kMargin,
            width: textWidth,
            height: textView.sizeThatFits(CGSize(width: textWidth, height: CGFloat.max)).height)
    }
    
    static func sizeThatFits(size: CGSize, repository: Repository) -> CGSize {
        
        let textWidth = size.width - kMargin * 3.0 - kIconWidth
        
        let attrString = NSAttributedString(string: repository.description,
            attributes: [NSFontAttributeName: self.appearance().textFont])
        
        let textSize = attrString.boundingRectWithSize(
            CGSize(width: textWidth, height: CGFloat.max),
            options: .UsesLineFragmentOrigin, context: nil)
        
        return CGSize(
            width: size.width,
            height: max(kIconWidth, textSize.height) + kMargin * 2.0)
    }
}

final class PBigCell: PBaseCell, HeightCalculable {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w = CGRectGetWidth(bounds)
        
        iconImageView.frame = CGRect(
            x: (w - kIconWidth) / 2,
            y: kMargin,
            width: kIconWidth,
            height: kIconWidth)
        
        let textWidth = w - kMargin * 2.0
        
        textView.frame = CGRect(
            x: kMargin,
            y: CGRectGetMaxY(iconImageView.frame) + kMargin,
            width: textWidth,
            height: textView.sizeThatFits(CGSize(width: textWidth, height: CGFloat.max)).height)
    }
    
    static func sizeThatFits(size: CGSize, repository: Repository) -> CGSize {
        
        let textWidth = size.width - kMargin * 2.0
        
        let attrString = NSAttributedString(string: repository.description,
            attributes: [NSFontAttributeName: self.appearance().textFont])
        
        let textSize = attrString.boundingRectWithSize(
            CGSize(width: textWidth, height: CGFloat.max),
            options: .UsesLineFragmentOrigin, context: nil)
        
        return CGSize(
            width: size.width,
            height: textSize.height + kMargin * 3.0 + kIconWidth)
    }
}

class ProgrammaticallyViewController: UITableViewController {
    
    let dataSource = RepositoryDataSource()
    
    init() {
        super.init(style: .Plain)
        PNormalCell.appearance().textFont = UIFont.systemFontOfSize(14.0)
        PBigCell.appearance().textFont = UIFont.italicSystemFontOfSize(14.0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        
        tableView.registerClass(PNormalCell.self, forCellReuseIdentifier: "Normal")
        tableView.registerClass(PBigCell.self, forCellReuseIdentifier: "Big")
        
        Repository.getRepositories { repos in
            self.dataSource.items.appendContentsOf(repos)
            self.tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let item = dataSource.items[indexPath.row]

        guard let cellClass = cellClassForRepository(item) as? HeightCalculable.Type else {
            return 44
        }
        
        return cellClass.sizeThatFits(
            CGSize(width: CGRectGetWidth(tableView.bounds), height: CGFloat.max),
            repository: item).height
    }
}
