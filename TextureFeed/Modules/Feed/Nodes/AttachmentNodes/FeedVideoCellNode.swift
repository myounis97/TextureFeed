//
//  FeedVideoNode.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 31/12/2021.
//

import Foundation
import AsyncDisplayKit

class FeedVideoCellNode:BaseCellNode {
    let attachment:Attachment
    
    let videoNode: ASVideoNode = {
        let node = ASVideoNode()
        node.shouldAutoplay = true
        node.shouldAutorepeat = true
        node.backgroundColor = .gray
        return node
    }()
    
    let asset:AVAsset
    
    init(attachment:Attachment) {
        self.attachment = attachment
        self.asset = AVAsset(url: URL(string: attachment.url)!)
        super.init()
        videoNode.url = URL(string: attachment.thumb)!
//        videoNode.asset = asset
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASRatioLayoutSpec(ratio: 1, child: videoNode)
    }
}
