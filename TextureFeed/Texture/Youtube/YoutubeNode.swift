//
//  YoutubeNode.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 01/01/2022.
//

import Foundation
import AsyncDisplayKit
import youtube_ios_player_helper

class YoutubeNode: BaseNode {
    
    //MARK: - Members
    
    private let attachment:Attachment
    
    private lazy var youtubeNode : ASDisplayNode = {
        return ASDisplayNode {() -> UIView in
            let view = YTPlayerView()
            view.delegate = self
            return view
        }
    }()
    
    //MARK: - Initialization
    
    init(attachment:Attachment) {
        self.attachment = attachment
        super.init()
    }
    
    override func didLoad() {
        super.didLoad()
        load(withVideoId: attachment.url)
    }
    
    private func load(withVideoId id:String) {
        //        (youtubeNode.view as? YTPlayerView)?.load(withVideoId: id, playerVars: ["playsinline": "1"])
    }
    
    override func didEnterPreloadState() {
        super.didEnterPreloadState()
        (youtubeNode.view as? YTPlayerView)?.cueVideo(byId: attachment.url, startSeconds: 0)
    }
    
    override func didEnterVisibleState() {
        super.didEnterVisibleState()
        
    }
    
    override func didExitVisibleState() {
        super.didExitVisibleState()
        pause()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASRatioLayoutSpec(ratio: 1, child: youtubeNode)
    }
    
    func play() {
        (youtubeNode.view as? YTPlayerView)?.playVideo()
    }
    
    func pause() {
        (youtubeNode.view as? YTPlayerView)?.pauseVideo()
        
    }
    
}

extension YoutubeNode : YTPlayerViewDelegate {
    func playerViewPreferredWebViewBackgroundColor(_ playerView: YTPlayerView) -> UIColor {
        .black
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playerState({[weak self] state, error in
            guard error == nil, let self = self else {
                return
            }
            if state == .cued {
                if self.isVisible {
                    //                    playerView.playVideo()
                }
            }
        })
    }
}
