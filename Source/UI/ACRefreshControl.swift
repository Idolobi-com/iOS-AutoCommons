//
//  ACRefreshControl.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 06/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import UIKit

public class ACRefreshControl: UIRefreshControl {
    
    weak var swipeRefreshDelegate: ACRefreshControlDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action:
            #selector(onSwipeRefresh(_:)), for: .valueChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onSwipeRefresh(_ sender: UIRefreshControl) {
        swipeRefreshDelegate?.onSwipeRefresh()
    }
    
    func isLoading(_ isLoading: Bool) {
        if isLoading {
            beginRefreshingManually()
        } else {
            self.endRefreshing()
        }
    }
    
    func beginRefreshingManually() {
        if let scrollView = superview as? UIScrollView {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y - frame.height), animated: true)
        }
        self.beginRefreshing()
    }
    
}

public protocol ACRefreshControlDelegate: class {
    func onSwipeRefresh()
}
