//
//  AutoLayoutTableViewController.swift
//  LayoutComparison
//
//  Created by Ryohei Kameyama on 2016/02/02.
//  Copyright © 2016年 codingcafe.jp. All rights reserved.
//

import UIKit

final class NormalCell: UITableViewCell, CellRepositorySupport {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
}

final class BigCell: UITableViewCell, CellRepositorySupport {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var iconImageView: UIImageView!
}

class AutoLayoutTableViewController: UITableViewController {
    
    let dataSource = RepositoryDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = dataSource
        
        Repository.getRepositories { repos in
            self.dataSource.items.appendContentsOf(repos)
            self.tableView.reloadData()
        }
    }
}
