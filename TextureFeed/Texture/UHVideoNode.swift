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
    
    private lazy var videoNode = { () -> ASVideoPlayerNode in
        let node = ASVideoPlayerNode()
        node.shouldAutoPlay = true
        node.shouldAutoRepeat = true
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
    
    func setThumb(_ url:URL) {
        self.videoNode.videoNode.url = url
    }
    
    func setVideoAsset(_ url: URL) {
        let asset = AVAsset(url: url)
        asset.loadValuesAsynchronously(forKeys: ["playable"], completionHandler: {[weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {[weak self] in
                asset.cancelLoading()
                self?.videoNode.asset = asset
            }
        })
    }
    
}
