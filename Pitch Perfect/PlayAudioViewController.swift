//
//  PlayAudioViewController.swift
//  Pitch Perfect
//
//  Created by Johannes Eichler on 08.03.15.
//  Copyright (c) 2015 Nigemizu. All rights reserved.
//

import UIKit
import AVFoundation

class PlayAudioViewController: UIViewController {
    
    var fileURL: NSURL?
    
    var audioPlayer: AVAudioPlayer!
    var audioEffectsPlayer: AudioEffectsPlayer!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(self.fileURL != nil){
            
            var audio: AVAudioPlayer? = AVAudioPlayer(contentsOfURL: fileURL, error: nil)
            
            audio!.enableRate = true
            self.audioPlayer = audio
            
            audioEffectsPlayer = AudioEffectsPlayer(filePathURL: fileURL!)
        }
        
        else {
            
            println("Could not find filepath \(fileURL)")
        
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func playAudio(atRate:Float) -> Void {

        if(self.audioPlayer != nil){
            
            audioEffectsPlayer.audioEngine.stop()
            audioEffectsPlayer.audioEngine.reset()
            
            self.audioPlayer!.rate = atRate
            self.audioPlayer!.stop()
            self.audioPlayer?.currentTime = 0.0
            self.audioPlayer!.play()
            
        }
    
    }
    
    
    
    @IBAction func playSlow(sender: UIButton) {
        
        self.playAudio(0.5)
        
    }
    
    
    @IBAction func playFast(sender: UIButton) {
        
        self.playAudio(2.0)
        
    }
    
    @IBAction func playChipmunked(sender: UIButton) {
        
        self.audioPlayer!.stop()
        audioEffectsPlayer.playPitchedAudio(1000)
        
    }
    
    @IBAction func playVader(sender: UIButton) {
        
        self.audioPlayer!.stop()
        audioEffectsPlayer.playPitchedAudio(-1000)
    }
    
    
    
    @IBAction func playEcho(sender: UIButton) {
        self.audioPlayer!.stop()
        audioEffectsPlayer.playAudioEcho()
        
    }
    
    

    @IBAction func stopAllAudio(sender: UIButton) {
        
        audioEffectsPlayer.stop()
        
        
        if(self.audioPlayer != nil && self.audioPlayer!.playing){
            
            self.audioPlayer!.stop()
        }
        
    }
    
    


}
