//
//  MediaViewController.swift
//  DatabaseConnect
//
//  Created by Eric Cauble on 1/21/16.
//  Copyright © 2016 Eric Cauble. All rights reserved.
//

import UIKit
import Player



class MediaPlayerViewController: UIViewController, PlayerDelegate {
    //variables
    var fileName :String?
    
    //constants
    private var player: Player!
    
    //outlets
    
    
    // MARK: object lifecycle
    convenience init() {
        self.init(nibName: nil, bundle:nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    // MARK:- View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let videoUrl = NSURL(string: kLocalHost + "/media/" + fileName!)!

        print(videoUrl)
        self.view.autoresizingMask = ([UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight])
        
        self.player = Player()
        self.player.delegate = self
        self.player.view.frame = self.view.bounds
        
        self.addChildViewController(self.player)
        self.view.addSubview(self.player.view)
        self.player.didMoveToParentViewController(self)
        
        self.player.setUrl(videoUrl)
        
        self.player.playbackLoops = true
        let swipeGestureRecognizer : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipeGestureReconizer:")
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTapGestureRecognizer:")
        swipeGestureRecognizer.direction = .Right
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.player.view.addGestureRecognizer(tapGestureRecognizer)
        self.player.view.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.player.playFromBeginning()
    }
    
    // MARK: UIGestureRecognizer
    
    func handleTapGestureRecognizer(gestureRecognizer: UITapGestureRecognizer) {
        switch (self.player.playbackState.rawValue) {
        case PlaybackState.Stopped.rawValue:
            self.player.playFromBeginning()
        case PlaybackState.Paused.rawValue:
            self.player.playFromCurrentTime()
        case PlaybackState.Playing.rawValue:
            self.player.pause()
        case PlaybackState.Failed.rawValue:
            self.player.pause()
        default:
            self.player.pause()
        }
    }
    
    func handleSwipeGestureReconizer(gestureReconizer: UISwipeGestureRecognizer) {
        self.player.pause()
        self.dismissViewControllerAnimated(true, completion: nil)
        print("swiped from right")
    }
    
    
    
    // MARK: PlayerDelegate
    
    func playerReady(player: Player) {
    }
    
    func playerPlaybackStateDidChange(player: Player) {
    }
    
    func playerBufferingStateDidChange(player: Player) {
    }
    
    func playerPlaybackWillStartFromBeginning(player: Player) {
    }
    
    func playerPlaybackDidEnd(player: Player) {
    }
    
}