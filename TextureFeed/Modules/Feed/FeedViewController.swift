//
//  ViewController.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 31/12/2021.
//

import AsyncDisplayKit

class FeedViewController: ASDKViewController<FeedNode> {
    
    //MARK: - Initialization

    override init() {
        super.init(node: FeedNode())
        navigationItem.title = "Feed"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
