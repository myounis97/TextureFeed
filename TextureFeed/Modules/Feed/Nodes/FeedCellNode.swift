//
//  FeedCell.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 31/12/2021.
//

import Foundation
import AsyncDisplayKit
import UIKit

class FeedCellNode : BaseCellNode {
    
    //MARK: - Members
    
    private let feed:Feed
    
    private lazy var body : FeedBodyNode = {
        let node = FeedBodyNode(feed: feed)
        return node
    }()
    
    private lazy var core : CoreFeedCellNode = {
        let node = CoreFeedCellNode(feed: feed, body: body)
        return node
    }()
    
    //MARK: - Initialization
    
    init(feed:Feed) {
        self.feed = feed
        super.init()
        backgroundColor = .white
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16), child: core)
    }
}
