//
//  RepositoryDataSource.swift
//  LayoutComparison
//
//  Created by Ryohei Kameyama on 2016/02/02.
//  Copyright © 2016年 codingcafe.jp. All rights reserved.
//

import UIKit

func cellIdentifierForRepository(item: Repository) -> String {
    let count = item.description.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
    
    if count > 90 {
        return "Big"
    } else {
        return "Normal"
    }
}

final class RepositoryDataSource: ArrayDataSource<Repository>, UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifierForRepository(item), forIndexPath: indexPath)
        
        if let cell = cell as? CellRepositorySupport {
            cell.setRepository(item)
        }
        cell.setNeedsLayout()
        
        return cell
    }
}
