//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Johannes Eichler on 06.03.15.
//  Copyright (c) 2015 Nigemizu. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingStatusLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.recordingStatusLabel.hidden = true
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(false)
        self.stopButton.hidden = true
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording"){
            
            let playAudioVC: PlayAudioViewController = segue.destinationViewController as PlayAudioViewController
            playAudioVC.fileURL = self.recordedAudio.filePathURL
        
        
        }
    }
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
        
        if(flag){
            
            self.recordedAudio = RecordedAudio()
            self.recordedAudio.filePathURL = recorder.url
            self.recordedAudio.title = recorder.url.lastPathComponent
            self.performSegueWithIdentifier( "stopRecording", sender: recordedAudio)
        
        
        
        
        }
        
        else {
            println("The recording was not sucessful")
            
            self.recordButton.enabled = true
            self.stopButton.hidden = true
            
            
        
        
        
            }
        
        
        
        
        
        
        
    }

    @IBAction func recordAudio(sender: UIButton) {
        
        self.recordingStatusLabel.hidden = false
        self.stopButton.hidden = false
        self.stopButton.enabled = true
        self.recordButton.enabled = false
        

        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        self.audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        self.audioRecorder.meteringEnabled = true
        self.audioRecorder.delegate = self
        self.audioRecorder.record()
        
    }

    @IBAction func stopRecording(sender: UIButton) {
        self.recordingStatusLabel.hidden = true
        self.stopButton.hidden = true
        self.recordButton.hidden = false
        self.recordButton.enabled = true
        self.audioRecorder.stop()
        // instanciate the singletion object

        var session = AVAudioSession.sharedInstance()
        session.setActive(false, error:nil)
        
        
        
        
    }
    
    
    
}

