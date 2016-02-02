//
//  ArrayDataSource.swift
//  LayoutComparison
//
//  Created by Ryohei Kameyama on 2016/02/02.
//  Copyright © 2016年 codingcafe.jp. All rights reserved.
//

import UIKit

public class ArrayDataSource<T>: NSObject {
    public var items = [T]()
    
    public func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
}
