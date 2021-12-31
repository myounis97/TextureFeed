//
//  FeedImageNode.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 31/12/2021.
//

import Foundation
import AsyncDisplayKit

class FeedImageCellNode: BaseCellNode {
    let attachment:Attachment
    
    let imageNode:ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.contentMode = .scaleAspectFill
        return node
    }()
    
    init(attachment:Attachment) {
        self.attachment = attachment
        super.init()
        imageNode.url = URL(string: attachment.url)!
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASRatioLayoutSpec(ratio: 1, child: imageNode)
    }
}
