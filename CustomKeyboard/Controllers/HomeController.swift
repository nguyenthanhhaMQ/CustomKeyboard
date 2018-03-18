//
//  HomeController.swift
//  CustomKeyboard
//
//  Created by Ha Nguyen on 3/18/18.
//  Copyright © 2018 Ha Nguyen. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    let presentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Present", for: .normal)
        button.addTarget(self, action: #selector(presentKeyboard), for: .touchUpInside)
        button.backgroundColor = UIColor.init(r: 0, g: 0, b: 0, a: 0.2)
        return button
    }()
    
    @objc func presentKeyboard() {
        showCustomerKeyboard(value: 2) { (value) in
            print("Got value: \(value)")
        }
    }
    
    func showCustomerKeyboard(value: Int?, onOK: @escaping (Double) -> Void) {
        let dlgKeyboard = DlgKeyboard()
        dlgKeyboard.modalPresentationStyle = .overFullScreen
        if let value = value {
            dlgKeyboard.valueLabel.text = String(value)
        }
        dlgKeyboard.onOK = onOK
        self.present(dlgKeyboard, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(presentButton)
        setupPresentButton()
    }
    
    func setupPresentButton() {
        presentButton.anchorWithConstraints(centerXAnchor: view.centerXAnchor,
                                            centerYAnchor: view.centerYAnchor,
                                            widthConstant: 60,
                                            heightConstant: 60)
    }
}
