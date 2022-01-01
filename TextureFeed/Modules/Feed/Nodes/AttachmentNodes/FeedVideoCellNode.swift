//
//  FeedVideoNode.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 31/12/2021.
//

import Foundation
import AsyncDisplayKit

class FeedVideoCellNode:BaseCellNode {
    
    //MARK: - Members
    
    private let attachment:Attachment
    
    private lazy var videoNode: UHVideoNode = {
        let node = UHVideoNode(ratio: 1, videoGravity: .resizeAspectFill)
        return node
    }()
    
    //MARK: - Initialization
        
    init(attachment:Attachment) {
        self.attachment = attachment
        super.init()
        videoNode.setVideoAsset(URL(string: attachment.url)!)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASRatioLayoutSpec(ratio: 1, child: videoNode)
    }
}
