//
//  NSAttributedStringUtils.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 31/12/2021.
//

import UIKit

func createReadmoreStrig(withSize size:CGFloat) -> NSAttributedString {
    let attributes = [
        NSAttributedString.Key.foregroundColor : UIColor.systemBlue,
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: size),
    ]
    return NSAttributedString(string: "...Readmore", attributes: attributes)
}

func createPopularStrig(withSize size:CGFloat) -> NSAttributedString {
    let attributes = [
        NSAttributedString.Key.foregroundColor : UIColor.white,
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: size, weight: .medium)
    ]
    return NSAttributedString(string: "Popular", attributes: attributes)
}
