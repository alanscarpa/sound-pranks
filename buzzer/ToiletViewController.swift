//
//  ViewController.swift
//  buzzer
//
//  Created by Alan Scarpa on 5/2/17.
//  Copyright © 2017 The Scarpa Group. All rights reserved.
//

import UIKit
import AVFoundation

class ToiletViewController: UIViewController, AVAudioPlayerDelegate {
    
    var mainAudioPlayer = AVAudioPlayer()
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainButton: UIButton!
    
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
    }
    
    // MARK: - AVAudioPlayer
    
    private func setUpAudioPlayer() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            mainAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "toiletSound", ofType: "wav")!))
            mainAudioPlayer.delegate = self
        } catch {
            present(UIAlertController.createSimpleAlert(withTitle: "Sound Error", message: error.localizedDescription), animated: true, completion: nil)
        }
        mainAudioPlayer.prepareToPlay()
    }
    
    // MARK: - AVAudioPlayerDelegate
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        returnToDefaultState()
    }
    
    // MARK: - Actions
    
    @IBAction func buzzerButtonTapped(_ sender: Any) {
        if mainAudioPlayer.isPlaying {
            returnToDefaultState()
        } else {
            mainAudioPlayer.currentTime = 0
            mainAudioPlayer.play()
            mainImageView.image = UIImage(named: "toiletOn")
            mainButton.setTitle("Tap to Stop", for: .normal)
        }
    }
    
    // MARK: - Private
    
    private func returnToDefaultState() {
        mainAudioPlayer.stop()
        mainImageView.image = UIImage(named: "toiletOff")
        mainButton.setTitle("Tap to Go!", for: .normal)
    }
    
}
