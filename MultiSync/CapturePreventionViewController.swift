//
//  CapturePreventionViewController.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 10/5/23.
//

import UIKit

final class CapturePreventionViewController: UIViewController {
    
    private var isCaptured: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func detectCapturing() {
        let sessions = UIApplication.shared.openSessions
        for screen in UIScreen.screens {
            if screen.responds(to: #selector(getter: UIScreen.isCaptured)) {
                isCaptured = true
                print(isCaptured)
            } else {
                return
            }
        }
    }
    
}
