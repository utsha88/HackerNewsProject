//
//  HackerNewsModelView.swift
//  Omnify
//
//  Created by Utsha Guha on 9/26/18.
//  Copyright © 2018 Utsha Guha. All rights reserved.
//

import Foundation
import UIKit

class HackerNewsModelView: UITableViewCell {
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsCommentCount: UILabel!
    @IBOutlet weak var newsAuthor: UILabel!
    @IBOutlet weak var newsTime: UILabel!
    @IBOutlet weak var newsURL: UILabel!
    @IBOutlet weak var newsScore: UILabel!
}
