//
//  AppController.swift
//  testAudioRecorder
//
//  Created by Ira Golubovich on 1/31/20.
//  Copyright © 2020 Ira Golubovich. All rights reserved.
//

import UIKit

class AppController {
    
    static func navigate(from navigationController: UIViewController, to navigationItem: NavigationItems, animated: Bool) {
        guard let viewController = navigationItem.viewControllerForNavigation else { return }
        navigationController.navigationController?.pushViewController(viewController, animated: animated)
    }
}
