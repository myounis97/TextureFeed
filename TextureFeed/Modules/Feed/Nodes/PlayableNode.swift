//
//  PlayableMediaProtocol.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 02/01/2022.
//

import UIKit
import AsyncDisplayKit

protocol PlayableNode {
    func getPlayableCell() -> PlayableCell?
    func getPlayableRect(to node:ASDisplayNode) -> CGRect?
}

protocol PlayableCell {
    func play()
    func pause()
    func id() -> String
}
