//
//  FeedYoutubeNode.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 31/12/2021.
//

import Foundation
import AsyncDisplayKit

class FeedYoutubeCellNode:BaseCellNode {
    
    //MARK: - Members
    
    private let attachment:Attachment
    
    private lazy var youtubeNode : YoutubeNode = {
        let node = YoutubeNode(attachment: attachment)
        return node
    }()
    
    //MARK: - Initialization
    
    init(attachment:Attachment) {
        self.attachment = attachment
        super.init()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASRatioLayoutSpec(ratio: 0.56, child: youtubeNode)
    }
}
