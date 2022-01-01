//
//  PopularNode.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 01/01/2022.
//

import UIKit
import AsyncDisplayKit
import Lottie

class PopularNode: BaseNode {
    
    //MARK: - Members
    
    private let flameNode = ASDisplayNode { () -> UIView in
        let lottieAnimation = AnimationView(name: "popular")
        lottieAnimation.contentMode = .scaleAspectFit
        lottieAnimation.loopMode = .loop
        lottieAnimation.backgroundColor = .clear
        return lottieAnimation
    }
    
    private lazy var background:BaseNode = {
        let node = BaseNode()
        node.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.6588235294, blue: 0.04705882353, alpha: 0.95)
        node.cornerRoundingType = .defaultSlowCALayer
        node.cornerRadius = 5
        node.onDidLoad { node in
            node.view.layer.masksToBounds = true
            node.view.layer.insertSublayer(self.gradientLayer, at: 0)
        }
        return node
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.name = "shimmerLayer"
        gradient.locations = [0.2, 0.5, 0.8]
        gradient.colors = [
            UIColor.white.withAlphaComponent(0).cgColor,
            UIColor.white.withAlphaComponent(0.431).cgColor,
            UIColor.white.withAlphaComponent(0).cgColor,
        ]
        gradient.calculatePoints(for: 20)
        return gradient
    }()
    
    private var playAnimation: Bool = false {
        didSet {
            if !playAnimation {
                gradientLayer.removeAnimation(forKey: "shimmer")
            } else {
                gradientLayer.removeAnimation(forKey: "shimmer")
                gradientLayer.add(makeAnimation(), forKey: "shimmer")
            }
        }
    }
    
    private lazy var textNode:ASTextNode = {
        let node = ASTextNode()
        return node
    }()
    
    
    //MARK: - Initialization
    
    override init() {
        super.init()
        textNode.attributedText = createPopularStrig(withSize: 13)
        flameNode.style.preferredSize = CGSize(width: 24, height: 24)
    }
    
    private func stopAnimation() {
        playAnimation = false
        (flameNode.view as? AnimationView)?.stop()
    }
    
    private func startAnimation() {
        playAnimation = true
        (flameNode.view as? AnimationView)?.play(completion: nil)
    }
    
    override func layout() {
        super.layout()
        self.gradientLayer.frame = CGRect(x: 0, y: 0, width: 31, height: self.frame.size.height)
    }
    
    fileprivate func makeAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.fromValue = textNode.frame.origin.x - 6
        animation.toValue = textNode.frame.origin.x + textNode.frame.size.width + flameNode.frame.size.width + 31
        animation.repeatCount = Float.greatestFiniteMagnitude
        animation.duration = 1.5
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        return animation
    }
    
    override func didEnterVisibleState() {
        super.didEnterVisibleState()
        startAnimation()
    }
    
    override func didExitVisibleState() {
        super.didExitVisibleState()
        stopAnimation()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let horizontalStack = ASStackLayoutSpec.horizontal()
        horizontalStack.spacing = 2
        horizontalStack.alignItems = .center
        horizontalStack.children = [textNode,flameNode]
        
        let backgroundSpec = ASBackgroundLayoutSpec(child: ASInsetLayoutSpec(insets: UIEdgeInsets(top: 1, left: 5, bottom: 1, right: 5), child: horizontalStack), background: background)
        
        return backgroundSpec
    }
    
}
