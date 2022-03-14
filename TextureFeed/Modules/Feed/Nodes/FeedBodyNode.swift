//
//  FeedBodyNode.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 31/12/2021.
//

import Foundation
import AsyncDisplayKit

class FeedBodyNode:BaseNode {
    
    //MARK: - Members
    
    private let feed:Feed
    
    private lazy var attachmentNode:FeedAttachmentsNode = {
        let node = FeedAttachmentsNode(feed: feed)
        return node
    }()
    
    //MARK: - Initialization

    init(feed:Feed) {
        self.feed = feed
        super.init()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let node = feed.contentType == FeedContent.ATTACHMENTS ?
            attachmentNode
        : feed.contentType == FeedContent.OG ?
        FeedOGNode(feed: feed) : BaseNode()
        return ASInsetLayoutSpec(insets: .zero, child: node)
    }
}

extension FeedBodyNode: PlayableNode {
    func getPlayableCell() -> PlayableCell? {
        guard feed.contentType == .ATTACHMENTS else {
            return nil
        }
        return attachmentNode.getPlayableCell()
    }
    
    func getPlayableRect(to node :UIView) -> CGRect? {
        guard feed.contentType == .ATTACHMENTS else {
            return nil
        }
        return self.view.convert(attachmentNode.getPlayableRect(to: self.view)!, to:node)
    }
}
