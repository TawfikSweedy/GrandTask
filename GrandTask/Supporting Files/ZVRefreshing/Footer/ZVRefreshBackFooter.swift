//
//  ZRefreshBackFooter.swift
//
//  Created by ZhangZZZZ on 16/4/1.
//  Copyright © 2016年 ZhangZZZZ. All rights reserved.
//

import UIKit

open class ZVRefreshBackFooter: ZVRefreshFooter {
    
    fileprivate var lastBottomDelta: CGFloat = 0.0
    fileprivate var lastRefreshCount: Int = 0
    
    override open var refreshState: RefreshState {
        get {
            return super.refreshState
        }
        set {
            guard let scrollView = self.scrollView else { return }
            
            let checked = self.checkState(newValue)
            if checked.result { return }
            super.refreshState = newValue
            
            switch newValue {
            case .idle, .noMoreData:
                if checked.oldState == .refreshing {
                    UIView.animate(withDuration: ConfigZZZ.AnimationDuration.slow, animations: {
                        scrollView.insetBottom -= self.lastBottomDelta
                        if self.isAutomaticallyChangeAlpha { self.alpha = 0.0 }
                    }, completion: { finished in
                        self.pullingPercent = 0.0
                        self.endRefreshingCompletionHandler?()
                    })
                }
                if .refreshing == checked.oldState &&
                    heightForContentBreakView > CGFloat(0.0)
                    && scrollView.totalDataCount != self.lastRefreshCount{
                    self.scrollView?.offsetY = scrollView.offsetY
                }
                break
            case .refreshing:
                self.lastRefreshCount = scrollView.totalDataCount
                UIView.animate(withDuration: ConfigZZZ.AnimationDuration.fast, animations: {
                    var bottom = self.height + self.scrollViewOriginalInset.bottom
                    if self.heightForContentBreakView < 0 {
                        bottom -= self.heightForContentBreakView
                    }
                    self.lastBottomDelta = bottom - scrollView.contentInset.bottom
                    scrollView.insetBottom = bottom
                    scrollView.offsetY = self.happenOffsetY + self.height
                }, completion: { finished in
                    self.executeRefreshCallback()
                })
                break
            default:
                break
            }
        }
    }
}

extension ZVRefreshBackFooter {
    
    override public func endRefreshing() {
        
        guard let scrollView = self.scrollView else { return }
        if scrollView.isKind(of: UICollectionView.classForCoder()) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01 / Double(NSEC_PER_SEC), execute: {
                super.endRefreshing()
            })
        } else {
            super.endRefreshing()
        }
    }
    
    override public func endRefreshingWithNoMoreData() {
        
        guard let scrollView = self.scrollView else { return }
        if scrollView.isKind(of: UICollectionView.classForCoder()) {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.01)) / Double(NSEC_PER_SEC), execute: {
                super.endRefreshingWithNoMoreData()
            })
        } else {
            super.endRefreshingWithNoMoreData()
        }
    }
}

extension ZVRefreshBackFooter {
    
    override open func scrollViewContentOffsetDidChanged(_ change: [NSKeyValueChangeKey : Any]?) {
        
        super.scrollViewContentOffsetDidChanged(change)
        
        guard self.refreshState != .refreshing else { return }
        guard let scrollView = self.scrollView else { return }
        
        self.scrollViewOriginalInset = scrollView.contentInset
        let currentOffsetY = scrollView.offsetY
        
        guard currentOffsetY > happenOffsetY  else { return }
        
        let pullingPercent = (currentOffsetY - happenOffsetY) / self.height
        
        if self.refreshState == .noMoreData {
            self.pullingPercent = pullingPercent
            return
        }
        
        if scrollView.isDragging {
            self.pullingPercent = pullingPercent
            let normal2pullingOffsetY = happenOffsetY + self.height
            if self.refreshState == .idle && currentOffsetY > normal2pullingOffsetY {
                self.refreshState = .pulling
            } else if self.refreshState == .pulling && currentOffsetY <= normal2pullingOffsetY {
                self.refreshState = .idle
            }
        } else if self.refreshState == .pulling {
            self.beginRefreshing()
        } else if pullingPercent < 1 {
            self.pullingPercent = pullingPercent
        }
    }
    
    override open func scrollViewContentSizeDidChanged(_ change: [NSKeyValueChangeKey : Any]?) {
        super.scrollViewContentSizeDidChanged(change)
        
        guard let scrollView = self.scrollView else { return }
        let contentHeight = scrollView.contentSize.height + self.ignoredScrollViewContentInsetBottom
        let scrollHeight = scrollView.height - self.scrollViewOriginalInset.top - self.scrollViewOriginalInset.bottom + self.ignoredScrollViewContentInsetBottom
        
        self.y = max(contentHeight, scrollHeight)
    }
    
    fileprivate var heightForContentBreakView: CGFloat {
        guard let scrollView = self.scrollView else { return 0.0 }
        let h = scrollView.height - self.scrollViewOriginalInset.bottom - self.scrollViewOriginalInset.top
        let height = scrollView.contentHeight - h
        return height
    }
    
    fileprivate var happenOffsetY: CGFloat {
        let deletaH = self.heightForContentBreakView
        if deletaH > 0 {
            return deletaH - self.scrollViewOriginalInset.top
        } else {
            return -self.scrollViewOriginalInset.top
        }
    }
}
