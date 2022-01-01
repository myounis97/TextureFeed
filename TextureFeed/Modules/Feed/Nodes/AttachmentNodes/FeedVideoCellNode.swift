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
    
    private lazy var videoPlayerNode = { () -> ASVideoPlayerNode in
        let node = ASVideoPlayerNode(url: URL(string: attachment.url)!)
        node.shouldAutoPlay = true
        node.shouldAutoRepeat = true
        node.muted = true
        node.controlsDisabled = true
        node.delegate = self
        node.gravity = AVLayerVideoGravity.resizeAspectFill.rawValue
        return node
    }()
    
    //MARK: - Initialization
        
    init(attachment:Attachment) {
        self.attachment = attachment
        super.init()
        videoPlayerNode.videoNode.url = URL(string: attachment.thumb)!
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASRatioLayoutSpec(ratio: 0.56, child: videoPlayerNode)
    }
}

extension FeedVideoCellNode : ASVideoPlayerNodeDelegate {
    func didTap(_ videoPlayer: ASVideoPlayerNode) {
        
    }
}
