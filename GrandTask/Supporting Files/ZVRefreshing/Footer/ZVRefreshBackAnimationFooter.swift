//
//  ZRefreshBackAnimationFooter.swift
//
//  Created by ZhangZZZZ on 16/4/1.
//  Copyright © 2016年 ZhangZZZZ. All rights reserved.
//

import UIKit

open class ZVRefreshBackAnimationFooter: ZVRefreshBackStateFooter {

    fileprivate(set) lazy var  animationView: UIImageView = {
        let animationView = UIImageView()
        animationView.backgroundColor = .clear
        return animationView
    }()

    fileprivate var _stateImages: [RefreshState: [UIImage]] = [:]
    fileprivate var _stateDurations: [RefreshState: TimeInterval] = [:]
    
    override open var pullingPercent: CGFloat {
        didSet {
            let imgs = self._stateImages[.idle] ?? []
            if self.refreshState != .idle || imgs.count == 0 { return }
            self.animationView.stopAnimating()
            var index = Int(CGFloat(imgs.count) * pullingPercent)
            if index >= imgs.count {
                index = imgs.count - 1
            }
            self.animationView.image = imgs[index]
        }
    }
    
    override open var refreshState: RefreshState {
        get {
            return super.refreshState
        }
        set {
            
            if self.checkState(newValue).0 { return }
            super.refreshState = newValue
            
            if newValue == .pulling || newValue == .refreshing {
                
                guard let images = self._stateImages[newValue], images.count > 0 else { return }
                self.animationView.stopAnimating()
                
                if images.count == 1 {
                    self.animationView.image = images.last
                } else {
                    self.animationView.animationImages = images
                    self.animationView.animationDuration = self._stateDurations[newValue] ?? 0
                    self.animationView.startAnimating()
                }
            } else if newValue == .idle {
                self.animationView.stopAnimating()
            }
        }
    }
}

extension ZVRefreshBackAnimationFooter {
    
    public func setImages(_ images: [UIImage], state: RefreshState){
        self.setImages(images, duration: Double(images.count) * 0.1, state: state)
    }
    
    public func setImages(_ images: [UIImage], duration: TimeInterval, state: RefreshState){
        if images.count == 0 { return }
        
        self._stateImages.updateValue(images, forKey: state)
        self._stateDurations.updateValue(duration, forKey: state)
        if let image = images.first {
            if image.size.height > self.height {
                self.height = image.size.height
            }
        }
    }
}

extension ZVRefreshBackAnimationFooter {
    
    override open func prepare() {
        super.prepare()

//        var GIFImages :[UIImage] = []
//        for i in 0 ... 20 {
//            var name = "200\(i)"
//            if i < 10{
//                name = "2000\(i)"
//            }
//            let img = UIImage(named: name)
//            GIFImages.append(img!)
//        }
//        setImages(GIFImages, state: .idle)
//        setImages(GIFImages, state: .pulling)
//        setImages(GIFImages, state: .refreshing)
        if self.animationView.superview == nil {
            self.addSubview(self.animationView)
        }
    }
    
    override open func placeSubViews() {
        super.placeSubViews()
        if self.animationView.constraints.count > 0 { return }
        self.animationView.frame = self.bounds
        if self.stateLabel.isHidden {
            self.animationView.contentMode = .center
        } else {
            self.animationView.contentMode = .right
            self.animationView.width = self.width * 0.5 - 90
        }
    }
}
