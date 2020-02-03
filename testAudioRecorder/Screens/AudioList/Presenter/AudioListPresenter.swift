//
//  AudioListPresenter.swift
//  testAudioRecorder
//
//  Created by Ira Golubovich on 2/3/20.
//  Copyright © 2020 Ira Golubovich. All rights reserved.
//

import Foundation

class  AudioListPresenter: AudioListPresenterProtocol {
    
    // MARK: - Public data
    var view: AudioListViewControllerProtocol?
    
    // MARK: - Private data
    private var recordings = [Recording]()
    
    // MARK: - Initializers
    init(view: AudioListViewControllerProtocol) {
        self.view = view
    }
    
    // MARK: - Private methods
    private func getCreationDate(for file: URL) -> Date {
        if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
            let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
            return creationDate
        } else {
            return Date()
        }
    }
    
    // MARK: - Public methods
    func fetchRecordings() {
        recordings.removeAll()
        
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
        for audio in directoryContents {
            let recording = Recording(fileURL: audio, createdAt: getCreationDate(for: audio))
            
            recordings.append(recording)
        }
        recordings.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedAscending})
    }
    
    func getRecordingsCount() -> Int {
        return recordings.count
    }
    
    func getAudio(index: Int) -> URL {
        return recordings[index].fileURL
    }
    
    func getAudioDate(index: Int) -> String {
        return GeneratorDate.dateDayMonthYearAnd12HoursFormatter(date: recordings[index].createdAt)
    }
}
