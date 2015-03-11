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
    
    var audioPlayer: AVAudioPlayer?
    var fileURL: NSURL?
    var audioFile: AVAudioFile?
    var audioEngine : AVAudioEngine?
    var pitchPlayer : AVAudioPlayerNode?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.audioEngine = AVAudioEngine()
        self.audioFile = AVAudioFile(forReading: self.fileURL, error: nil)

        // Do any additional setup after loading the view.

        
        if(self.fileURL != nil){
            
            var audio: AVAudioPlayer? = AVAudioPlayer(contentsOfURL: fileURL, error: nil)
            
            audio!.enableRate = true
            
            self.audioPlayer = audio
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
            
            self.audioPlayer!.rate = atRate
            self.audioPlayer!.stop()
            self.audioPlayer?.currentTime = 0.0
            self.audioPlayer!.play()
            
        }
    
    }
    
    
    func playPitchedAudio(withPitch:Float) -> Void {
        
        self.audioPlayer?.stop()
        self.audioEngine!.stop()
        self.audioEngine!.reset()
        
        
        self.pitchPlayer = AVAudioPlayerNode()
        var timePitch = AVAudioUnitTimePitch()
        timePitch.pitch = withPitch
        
        //var echo = AVAudioUnitReverb()
        
        
        self.audioEngine!.attachNode(pitchPlayer)
        self.audioEngine!.attachNode(timePitch)
        
        self.audioEngine!.connect(pitchPlayer, to: timePitch, format: nil)
        self.audioEngine!.connect(timePitch, to: audioEngine!.outputNode, format: nil)
        
        
        self.pitchPlayer!.scheduleFile(self.audioFile, atTime: nil, completionHandler: nil)
        self.audioEngine!.startAndReturnError(nil)
        self.pitchPlayer!.play()
        
    }
    
    
    @IBAction func playSlow(sender: UIButton) {
        
        self.playAudio(0.5)
        
    }
    
    
    @IBAction func playFast(sender: UIButton) {
        
        self.playAudio(2.0)
        
    }
    
    @IBAction func playChipmunked(sender: UIButton) {
        
        self.playPitchedAudio(1000)
        
    }
    
    @IBAction func playVader(sender: UIButton) {
        
        self.playPitchedAudio(-1000)
    }
    

    @IBAction func stopAllAudio(sender: UIButton) {
        
        if(self.pitchPlayer != nil && self.pitchPlayer!.playing)
        
        {
            self.pitchPlayer!.stop()
            
        }
        
        
        
        if(self.audioPlayer != nil && self.audioPlayer!.playing){
            
            self.audioPlayer!.stop()
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
