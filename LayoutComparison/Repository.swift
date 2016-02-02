//
//  Repository.swift
//  LayoutComparison
//
//  Created by Ryohei Kameyama on 2016/02/02.
//  Copyright © 2016年 codingcafe.jp. All rights reserved.
//

import UIKit

struct Repository {
    var name: String
    var description: String
    var avatarURL: String
}

extension Repository {
    static func getRepositories(completion: ([Repository]) -> Void) {
        let path = NSBundle.mainBundle().pathForResource("repositories", ofType: "json")!
        let json = try! NSJSONSerialization.JSONObjectWithData(NSData.init(contentsOfFile: path)!, options: .AllowFragments)
        
        if let dict = json as? Dictionary<String, AnyObject> {
            if let repos = dict["items"] as? [Dictionary<String, AnyObject>] {
                completion(repos.map {
                    Repository(
                        name: $0["name"] as? String ?? "",
                        description: $0["description"] as? String ?? "",
                        avatarURL: ($0["owner"] as? Dictionary<String, AnyObject>)?["avatar_url"] as? String ?? ""
                    )
                })
            }
        }
    }
}

