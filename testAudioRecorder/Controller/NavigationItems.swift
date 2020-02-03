//
//  Navigation.swift
//  testAudioRecorder
//
//  Created by Ira Golubovich on 1/31/20.
//  Copyright © 2020 Ira Golubovich. All rights reserved.
//

import Foundation
import UIKit

enum NavigationItems {
    case recordedAudioList(urls: [URL])
    
    private var storyboardName: String {
        switch self {
        case .recordedAudioList:
            return "RecordedAudioListViewController"
        }
    }
    
    private var viewControllerId: String {
        switch self {
        case .recordedAudioList:
            return "RecordedAudioListViewController"
        }
    }
    
    var viewControllerForNavigation: UIViewController? {
        let viewController = createViewController()
        switch self {
        case .recordedAudioList(let urls):
            return createRecordedAudioListViewController(viewController: viewController, urls: urls)
            
        }
    }
    
    private func createViewController() -> UIViewController {
        let viewController = UIStoryboard(name: self.storyboardName, bundle: nil).instantiateViewController(withIdentifier: self.viewControllerId)
        
        return viewController
    }
    
    private func createRecordedAudioListViewController(viewController: UIViewController, urls: [URL]) -> UIViewController {
        guard let viewController = viewController as? RecordedAudioListViewController else {
            assertionFailure("Can't cast to ScannedDataViewController")
            return UIViewController()
        }
        
        viewController.audioUrls = urls
        return viewController
    }
}
