//
//  RecordedAudioListViewController.swift
//  testAudioRecorder
//
//  Created by Ira Golubovich on 1/31/20.
//  Copyright © 2020 Ira Golubovich. All rights reserved.
//

import UIKit
import AVKit

class RecordedAudioListViewController: UITableViewController, AVAudioPlayerDelegate {
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    var audioUrls = [URL]()
    
    func playAudio(index: Int) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioUrls[index], fileTypeHint: nil)
            audioPlayer?.delegate = self
            audioPlayer?.volume = 10.0
            audioPlayer?.play()
        } catch {
            showError(title: "Error", message: "Someting went wrong.")
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
}

extension RecordedAudioListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return audioUrls.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AudioCell") as? RecordedAudioListTableViewCell else { return UITableViewCell() }
        cell.audioLabel.text = "Audio \(indexPath.row)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playAudio(index: indexPath.row)
    }
}
