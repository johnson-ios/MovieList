//
//  SplashViewController.swift
//  MovieApp
//
//  Created by jaya kumar on 01/08/24.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        // Setup splash screen with logo or animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.navigateToMainScreen()
        }
    }

    private func navigateToMainScreen() {
        print("Navigating to Main Screen")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController {
            let navController = UINavigationController(rootViewController: mainVC)
            navController.modalTransitionStyle = .crossDissolve
            navController.modalPresentationStyle = .fullScreen
            present(navController, animated: true, completion: nil)
        } else {
            print("Failed to instantiate MainViewController")
        }
    }

}
