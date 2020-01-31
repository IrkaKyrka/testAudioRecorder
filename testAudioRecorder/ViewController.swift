//
//  ViewController.swift
//  AVAudioRecorderTest
//
//  Created by Ira Golubovich on 1/31/20.
//  Copyright © 2020 Ira Golubovich. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate {
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordingImage: UIImageView!
    @IBOutlet weak var recordingTextLabel: UILabel!
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRecordingSession()
    }
    
    @IBAction func onStartButton(_ sender: UIButton) {
        animateRecordingImage()
        startRecoding()
    }
    
    @IBAction func onStopButton(_ sender: UIButton) {
        self.recordingImage.layer.removeAllAnimations()
        self.recordingTextLabel.layer.removeAllAnimations()
        stopRecording()
    }
    
    func setRecordingSession() {
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            
            switch AVAudioSession.sharedInstance().recordPermission {
            case AVAudioSessionRecordPermission.denied:
                showSettings()
            case AVAudioSessionRecordPermission.undetermined:
            recordingSession.requestRecordPermission({ _ in
                    print("User confirmed permission request")
            })
            default:
                break
            }
        } catch {
            showError(title: "Failed to record", message: "Please, try later.")
        }
    }
    
    func showError(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(action)
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
    
    func showSettings() {
        let alertController = UIAlertController (title: "Go to App Settings", message: "Go to App Settings?", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in

            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)")
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
    
    func startRecoding() {
        let audioFile = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        let settings: [String : Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFile, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
        } catch {
            stopRecording()
        }
        
    }
    
    func stopRecording() {
        audioRecorder.stop()
        audioRecorder = nil
    }
    
    func getDocumentsDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func animateRecordingImage() {
        UIView.animate(withDuration: 2.0, delay: 0, options: [.repeat], animations: { () -> Void in
            self.recordingImage?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.recordingTextLabel?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }, completion: {(_ finished: Bool) -> Void in
            UIView.animate(withDuration: 2.0, animations: {() -> Void in
                self.recordingImage?.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.recordingTextLabel?.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        })
    }
}
// MARK: - AVAudioRecorderDelegate
extension ViewController {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        recorder
    }
}
