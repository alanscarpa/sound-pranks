//
//  ViewController.swift
//  buzzer
//
//  Created by Alan Scarpa on 5/2/17.
//  Copyright © 2017 The Scarpa Group. All rights reserved.
//

import UIKit
import AVFoundation

class ClipperViewController: UIViewController, AVAudioPlayerDelegate {

    var buzzingAudioPlayer = AVAudioPlayer()
    var cuttingAudioPlayer = AVAudioPlayer()
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var swipeLabel: UILabel!
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainButton.layer.cornerRadius = 12
        setUpAudioPlayer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        returnToDefaultState()
        swipeLabel.isHidden = true
    }
    
    private func returnToDefaultState() {
        cuttingAudioPlayer.stop()
        buzzingAudioPlayer.stop()
        mainImageView.image = UIImage(named: "clippersOff")
        mainButton.setTitle("Tap to Buzz!", for: .normal)
    }
    
    // MARK: - AVAudioPlayer
    
    private func setUpAudioPlayer() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            buzzingAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "buzzSound", ofType: "wav")!))
            buzzingAudioPlayer.numberOfLoops = -1
            buzzingAudioPlayer.delegate = self
            cuttingAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "clipperCutting", ofType: "wav")!))
            cuttingAudioPlayer.numberOfLoops = -1
        } catch {
            present(UIAlertController.createSimpleAlert(withTitle: "Sound Error", message: error.localizedDescription), animated: true, completion: nil)
        }
        buzzingAudioPlayer.prepareToPlay()
        cuttingAudioPlayer.prepareToPlay()
    }

    // MARK: - Actions
    
    @IBAction func buzzerButtonTapped(_ sender: Any) {
        if buzzingAudioPlayer.isPlaying {
            returnToDefaultState()
        } else {
            buzzingAudioPlayer.currentTime = 0
            buzzingAudioPlayer.play()
            mainImageView.image = UIImage(named: "clippersOn")
            mainButton.setTitle("Hold to Cut!", for: .normal)
        }
    }
    
    @IBAction func buzzButtonLongPressHeld(_ sender: AnyObject) {
        if sender.state == .began, buzzingAudioPlayer.isPlaying {
            cuttingAudioPlayer.play()
        } else if sender.state == .ended {
            cuttingAudioPlayer.stop()
        }
    }

}
