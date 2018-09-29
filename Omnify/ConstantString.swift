//
//  ConstantString.swift
//  Omnify
//
//  Created by Utsha Guha on 9/27/18.
//  Copyright © 2018 Utsha Guha. All rights reserved.
//

import Foundation

struct ConstantString {
    static let kHNFetchTopStoriesURL           = "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty"
    static let kHNNewsCellID                   = "NewsCell"
    static let kHNNewsCommCountKey             = "descendants"
    static let kHNNewsTimeKey                  = "time"
    static let kHNNewsScoreKey                 = "score"
    static let kHNNewsTitleKey                 = "title"
    static let kHNNewsAuthorKey                = "by"
    static let kHNNewsURLKey                   = "url"
    static let kHNNewsCommentIdsKey            = "kids"
    static let kHNNewsCommentTextKey           = "text"
    static let kHNNewsDetailsSegue             = "NewsDetails"
    static let kHNCommentCellID                = "CommentCell"
    
    static let kHNNetworkErrorHeading          = "Server Connection Error"
    static let kHNNetworkErrorMessage          = "Currently we are not able to connect to the server. Kindly try again after some time."
    static let kHNNAlertOK                     = "OK"
}
