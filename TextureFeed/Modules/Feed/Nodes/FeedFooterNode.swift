//
//  FeedFooterNode.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 31/12/2021.
//

import Foundation
import AsyncDisplayKit
import Lottie
class FeedFooterNode:BaseCellNode {
    
    //MARK: - Members
    
    private let feed:Feed
    
    private lazy var shareButton:ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(named: "share")
        node.style.preferredSize = CGSize(width: 23, height: 23)
        return node
    }()
    
    private lazy var favoriteButton:ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(named: "star")
        node.style.preferredSize = CGSize(width: 23, height: 23)
        return node
    }()
    
    private lazy var commentButton:ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(named: "comment")
        node.style.preferredSize = CGSize(width: 23, height: 23)
        return node
    }()
    
    private lazy var dateNode:ASTextNode = {
        let node = ASTextNode()
        return node
    }()
    
    private lazy var reactionsNode:ReactionsNode = {
        let node = ReactionsNode(feed: feed)
        return node
    }()
    
    private let flameNode = ASDisplayNode { () -> UIView in
        let lottieAnimation = AnimationView(name: "popular")
        lottieAnimation.contentMode = .scaleAspectFit
        lottieAnimation.loopMode = .loop
        lottieAnimation.backgroundColor = .clear
        return lottieAnimation
    }
    
    //MARK: - Initialization
    
    init(feed:Feed) {
        self.feed = feed
        super.init()
        dateNode.attributedText = feed.attributedStringForDate(withSize: 12)
        flameNode.style.preferredSize = CGSize(width: 30, height: 30)
    }
    
    override func didEnterVisibleState() {
        super.didEnterVisibleState()
        (flameNode.view as? AnimationView)?.play(completion: nil)
    }
    
    override func didExitVisibleState() {
        super.didExitVisibleState()
        (flameNode.view as? AnimationView)?.stop()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.spacing = 8
        
        let spacer = ASLayoutSpec()
        spacer.style.flexGrow = 1.0
        
        let horizontalStack = ASStackLayoutSpec.horizontal()
        horizontalStack.spacing = 16
        horizontalStack.alignItems = .center
        
        horizontalStack.children = [
            commentButton,favoriteButton,flameNode,spacer,shareButton
        ]
        
        verticalStack.children = [
            horizontalStack,
            dateNode
        ]
        
        verticalStack.style.preferredLayoutSize = .init(width: .init(unit: .fraction, value: 1), height: .init(unit: .auto, value: 0))
        
        let centerSpec = ASCenterLayoutSpec(centeringOptions: .X, sizingOptions: [], child: reactionsNode)
        
        let overlaySpec = ASOverlayLayoutSpec(child: verticalStack, overlay: centerSpec)
        
        return overlaySpec
    }
    
}
