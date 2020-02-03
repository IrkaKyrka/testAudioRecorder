//
//  AudioListPresenterProtocol.swift
//  testAudioRecorder
//
//  Created by Ira Golubovich on 2/3/20.
//  Copyright © 2020 Ira Golubovich. All rights reserved.
//

import Foundation

protocol AudioListPresenterProtocol {
    func fetchRecordings()
    func getRecordingsCount() -> Int
    func getAudio(index: Int) -> URL
    func getAudioDate(index: Int) -> String
}
