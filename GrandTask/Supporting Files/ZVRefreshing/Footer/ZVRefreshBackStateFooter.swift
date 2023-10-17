//
//  ZRefreshBackStateFooter.swift
//
//  Created by ZhangZZZZ on 16/4/1.
//  Copyright © 2016年 ZhangZZZZ. All rights reserved.
//

import UIKit

open class ZVRefreshBackStateFooter: ZVRefreshBackFooter {
    
    public fileprivate(set) lazy var stateLabel: UILabel = .default
    public var labelInsetLeft: CGFloat = 24.0
    fileprivate var _stateTitles:[RefreshState: String] = [:]
    
    open override var tintColor: UIColor! {
        get {
            return super.tintColor
        }
        set {
            super.tintColor = newValue
            self.stateLabel.textColor = newValue
        }
    }
    
    override open var refreshState: RefreshState {
        get {
            return super.refreshState
        }
        set {
            if self.checkState(newValue).result { return }
            super.refreshState = newValue
            self.stateLabel.text = self._stateTitles[newValue]
        }
    }
}

extension ZVRefreshBackStateFooter {
    
    public func setTitle(_ title: String, forState state: RefreshState) {
        self._stateTitles.updateValue(title, forKey: state)
        self.stateLabel.text = self._stateTitles[self.refreshState]
    }
}

extension ZVRefreshBackStateFooter {
    
    override open func prepare() {
        super.prepare()
        
        if self.stateLabel.superview == nil {
            self.addSubview(self.stateLabel)
        }
        
        self.setTitle(local(string: ConstantsZZZ.Footer.Back.idle), forState: .idle)
        self.setTitle(local(string: ConstantsZZZ.Footer.Back.pulling), forState: .pulling)
        self.setTitle(local(string: ConstantsZZZ.Footer.Back.refreshing), forState: .refreshing)
        self.setTitle(local(string: ConstantsZZZ.Footer.Back.noMoreData), forState: .noMoreData)
    }
    
    override open func placeSubViews() {
        super.placeSubViews()
        if self.stateLabel.constraints.count > 0 { return }
        self.stateLabel.frame = self.bounds
    }
}
