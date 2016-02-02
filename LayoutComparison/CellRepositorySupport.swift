//
//  CellRepositorySupport.swift
//  LayoutComparison
//
//  Created by Ryohei Kameyama on 2016/02/02.
//  Copyright © 2016年 codingcafe.jp. All rights reserved.
//

import UIKit
import Kingfisher

protocol CellRepositorySupport {
    var iconImageView: UIImageView! { get }
    var textView: UITextView! { get }
}

extension CellRepositorySupport {
    func setRepository(repo: Repository) {
        textView.text = repo.description
        if let url = NSURL(string: repo.avatarURL) {
            iconImageView.kf_setImageWithURL(url)
        }
    }
}
