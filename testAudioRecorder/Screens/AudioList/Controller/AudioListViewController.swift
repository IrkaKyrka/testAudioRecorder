//
//  RecordedAudioListViewController.swift
//  testAudioRecorder
//
//  Created by Ira Golubovich on 1/31/20.
//  Copyright © 2020 Ira Golubovich. All rights reserved.
//

import UIKit
import AVKit

class AudioListViewController: UITableViewController, AVAudioPlayerDelegate, AudioListViewControllerProtocol {
    
    // MARK: - Public Data
    var presenter: AudioListPresenterProtocol!
    
    // MARK: - Private Data
    private var audioPlayer: AVAudioPlayer?
    private var audioRecorder: AVAudioRecorder?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.fetchRecordings()
    }
    
    // MARK: - Private methods
    private func playAudio(index: Int) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: presenter.getAudio(index: index), fileTypeHint: nil)
            audioPlayer?.delegate = self
            audioPlayer?.volume = 10.0
            audioPlayer?.play()
        } catch {
            showError(title: "Error", message: "Someting went wrong.")
        }
    }
    
    // MARK: - Public methods
    func showError(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(action)
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
}

// MARK: - UITableViewDelegate
extension AudioListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getRecordingsCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AudioCell") as? AudioListTableViewCell else { return UITableViewCell() }
        cell.audioLabel.text = "Audio \(presenter.getAudioDate(index: indexPath.row))"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playAudio(index: indexPath.row)
    }
}
