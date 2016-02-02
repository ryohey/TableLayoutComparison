//
//  IndexViewController.swift
//  LayoutComparison
//
//  Created by Ryohei Kameyama on 2016/02/02.
//  Copyright © 2016年 codingcafe.jp. All rights reserved.
//

import UIKit

class IndexViewController: UITableViewController {
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            if let vc = UIStoryboard(name: "AutoLayoutTableViewController", bundle: nil).instantiateInitialViewController() {
                navigationController?.pushViewController(vc, animated: true)
            }
        case 1:
            let vc = ProgrammaticallyViewController()
            navigationController?.pushViewController(vc, animated: true)
        default: break
        }
    }
}
