//
//  FeedYoutubeNode.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 31/12/2021.
//

import Foundation
import AsyncDisplayKit

class FeedYoutubeCellNode:BaseCellNode {
    let attachment:Attachment
    
    let baseNode : BaseNode = {
        let node = BaseNode()
        return node
    }()
    
    init(attachment:Attachment) {
        self.attachment = attachment
        super.init()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .zero, child: baseNode)
    }
}
