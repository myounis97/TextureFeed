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
        node.shouldAutoPlay = false
        node.shouldAutoRepeat = true
        node.muted = true
        node.controlsDisabled = true
        node.delegate = self
        node.placeholderImageURL = URL(string: attachment.thumb)!
        node.gravity = AVLayerVideoGravity.resizeAspectFill.rawValue
        return node
    }()
    
    //MARK: - Initialization
        
    init(attachment:Attachment) {
        self.attachment = attachment
        super.init()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASRatioLayoutSpec(ratio: 0.56, child: videoPlayerNode)
    }
    
    override func didExitVisibleState() {
        super.didExitVisibleState()
        pause()
    }
}

extension FeedVideoCellNode : ASVideoPlayerNodeDelegate {
    func didTap(_ videoPlayer: ASVideoPlayerNode) {
        
    }
}

extension FeedVideoCellNode: PlayableCell {
    
    func id() -> String {
        return "\(attachment.id)"
    }
    
    func play() {
        videoPlayerNode.play()
    }
    
    func pause() {
        videoPlayerNode.pause()
    }
}
