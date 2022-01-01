//
//  UHVideoNode.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 01/01/2022.
//

import Foundation
import AsyncDisplayKit

class UHVideoNode:BaseNode {
    
    //MARK: - Members
    
    private let ratio: CGFloat
    private let videoGravity: AVLayerVideoGravity
    
    private lazy var videoNode = { () -> ASVideoNode in
        let node = ASVideoNode()
        node.shouldAutoplay = true
        node.shouldAutorepeat = true
        node.muted = true
        node.gravity = videoGravity.rawValue
        return node
    }()
    
    //MARK: - Initialization
    
    required init(ratio: CGFloat,
                  videoGravity: AVLayerVideoGravity) {
        self.ratio = ratio
        self.videoGravity = videoGravity
        super.init()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASRatioLayoutSpec(ratio: self.ratio, child: self.videoNode)
    }
    
    func setVideoAsset(_ url: URL) {
        let asset = AVAsset(url: url)
        asset.loadValuesAsynchronously(forKeys: ["playable"], completionHandler: {
            DispatchQueue.main.async {
                asset.cancelLoading()
                self.videoNode.asset = asset
            }
        })
    }
    
}
