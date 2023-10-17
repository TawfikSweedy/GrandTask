//
//  ZRefreshAutoStateFooter.swift
//
//  Created by ZhangZZZZ on 16/3/31.
//  Copyright © 2016年 ZhangZZZZ. All rights reserved.
//

import UIKit

open class ZVRefreshAutoStateFooter: ZVRefreshAutoFooter {
    
    public fileprivate(set) lazy var stateLabel: UILabel = { [unowned self] in
        let label: UILabel = .default
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(.init(target: self,
                                         action: #selector(ZVRefreshAutoStateFooter.stateLabelClicked)))
        return label
    }()
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
            if self.checkState(newValue).0 { return }
            super.refreshState = newValue
            
            if self.stateLabel.isHidden && newValue == .refreshing {
                self.stateLabel.text = nil
            } else {
                self.stateLabel.text = self._stateTitles[newValue]
            }
        }
    }
}

extension ZVRefreshAutoStateFooter {
    
    public func setTitle(_ title: String?, forState state: RefreshState) {
        if title == nil {return}
        self._stateTitles.updateValue(title!, forKey: state)
        self.stateLabel.text = self._stateTitles[self.refreshState]
    }
}

extension ZVRefreshAutoStateFooter {
    
    override open func prepare() {
        super.prepare()
        
        if self.stateLabel.superview == nil {
            self.addSubview(self.stateLabel)
        }
                
        self.setTitle(local(string: ConstantsZZZ.Footer.Auto.idle) , forState: .idle)
        self.setTitle(local(string: ConstantsZZZ.Footer.Auto.refreshing), forState: .refreshing)
        self.setTitle(local(string: ConstantsZZZ.Footer.Auto.noMoreData), forState: .noMoreData)
    }
    
    override open func placeSubViews() {
        super.placeSubViews()
        
        if self.stateLabel.constraints.count > 0 { return }
        self.stateLabel.frame = self.bounds
    }
    
    @objc internal func stateLabelClicked() {
        if self.refreshState == .idle { self.beginRefreshing() }
    }
}
