//
//  DlgKeyboard.swift
//  CustomKeyboard
//
//  Created by Ha Nguyen on 3/18/18.
//  Copyright © 2018 Ha Nguyen. All rights reserved.
//

import UIKit

class DlgKeyboard: UIViewController {
    
    let BUTTON_SIZE: CGFloat = 60
    let BUTTON_SPACING: CGFloat = 15
    let BUTTON_COLOR: UIColor = UIColor.init(r: 0, g: 0, b: 0, a: 0.9)
    let BUTTON_BACKGROUNDCOLOR: UIColor = UIColor.init(r: 0, g: 0, b: 0, a: 0.1)
    
    var onOK: ((Double) -> Void)?
    
    var isFloatingPoint: Bool = false
    
    var numberButtons: [UIButton] = []
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(r: 0, g: 0, b: 0, a: 0.3)
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var valueLabel: PaddedLabel = {
        let label = PaddedLabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.backgroundColor = BUTTON_BACKGROUNDCOLOR
        label.text = ""
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        return label
    }()
    
    lazy var buttonsView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = BUTTON_SPACING
        return stackView
    }()
    
    lazy var dotButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(".", for: .normal)
        styleButton(button: button)
        button.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var clearButton: UIButton = {
        let button = UIButton(type: .system)
        var img = UIImage(named: "ic_clear")!
        img = Utils.resizeImage(image: img, targetSize: CGSize(width: img.size.width * 0.7, height: img.size.height * 0.7))
        button.setImage(img, for: .normal)
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.tintColor = .black
        styleButton(button: button)
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        styleActionButton(button: button)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return button
    }()
    
    lazy var okButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("OK", for: .normal)
        styleActionButton(button: button)
        button.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func okButtonTapped() {
        if let number = Double(valueLabel.text!) {
            onOK!(number)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func styleActionButton(button: UIButton) {
        button.anchorWithConstraints(heightConstant: 40)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.backgroundColor = BUTTON_BACKGROUNDCOLOR
        button.titleLabel?.textAlignment = .center
    }
    
    func styleButton(button: UIButton) {
        button.anchorWithConstraints(widthConstant: BUTTON_SIZE,
                                     heightConstant: BUTTON_SIZE)
        button.layer.cornerRadius = BUTTON_SIZE / 2
        button.backgroundColor = BUTTON_BACKGROUNDCOLOR
        button.setTitleColor(BUTTON_COLOR, for: .normal)
        button.layer.masksToBounds = true
    }
    
    @objc func clearButtonTapped() {
        if let value = valueLabel.text, value.count > 0 {
            valueLabel.text = String(value.dropLast())
            if (value.last == ".") {
                isFloatingPoint = false
            }
        }
    }
    
    lazy var firstRow: UIStackView = rowStack()
    
    lazy var secondRow: UIStackView = rowStack()
    
    lazy var thirdRow: UIStackView = rowStack()
    
    lazy var actionRow: UIStackView = rowStack()
    
    func rowStack() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = BUTTON_SPACING
        return stackView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        view.addSubview(mainView)
        setupMainView()
        
        view.addSubview(containerView)
        setupContainerView()
        
        containerView.addSubview(valueLabel)
        setupValueLabel()
        
        containerView.addSubview(buttonsView)
        setupButtonsView()
        
        adjustValueLabel()
        
        createNumberButtons()
        
        buttonsView.addArrangedSubview(firstRow)
        setupFirstRow()
        
        buttonsView.addArrangedSubview(secondRow)
        setupSecondRow()
        
        buttonsView.addArrangedSubview(thirdRow)
        setupThirdRow()
        
        buttonsView.addArrangedSubview(actionRow)
        setupActionRow()
    }
    
    func setupMainView() {
        mainView.anchorWithConstraints(topAnchor: view.topAnchor,
                                       leftAnchor: view.leftAnchor,
                                       bottomAnchor: view.bottomAnchor,
                                       rightAnchor: view.rightAnchor)
        mainView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        self.mainView.addGestureRecognizer(tap)
    }
    
    func setupValueLabel() {
        valueLabel.anchorWithConstraints(topAnchor: containerView.topAnchor,
                                         topConstant: 40,
                                         heightConstant: 40)
    }
    
    func adjustValueLabel() {
        valueLabel.anchorWithConstraints(leftAnchor: buttonsView.leftAnchor,
                                         rightAnchor: buttonsView.rightAnchor)
    }
    
    func setupButtonsView() {
        buttonsView.anchorWithConstraints(topAnchor: valueLabel.bottomAnchor,
                                          topConstant: 20,
                                          centerXAnchor: containerView.centerXAnchor)
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupContainerView() {
        containerView.anchorWithConstraints(leftAnchor: view.leftAnchor,
                                            leftConstant: 100,
                                            bottomAnchor: view.bottomAnchor,
                                            bottomConstant: 50,
                                            centerXAnchor: view.centerXAnchor,
                                            heightConstant: 400)
    }
    
    func setupFirstRow() {
        firstRow.addArrangedSubview(numberButtons[9])
        firstRow.addArrangedSubview(numberButtons[8])
        firstRow.addArrangedSubview(numberButtons[7])
        firstRow.addArrangedSubview(clearButton)
    }
    
    func setupSecondRow() {
        secondRow.addArrangedSubview(numberButtons[6])
        secondRow.addArrangedSubview(numberButtons[5])
        secondRow.addArrangedSubview(numberButtons[4])
        secondRow.addArrangedSubview(dotButton)
    }
    
    func setupThirdRow() {
        thirdRow.addArrangedSubview(numberButtons[3])
        thirdRow.addArrangedSubview(numberButtons[2])
        thirdRow.addArrangedSubview(numberButtons[1])
        thirdRow.addArrangedSubview(numberButtons[0])
    }
    
    func setupActionRow() {
        actionRow.addArrangedSubview(cancelButton)
        actionRow.addArrangedSubview(okButton)
        actionRow.distribution = .fillEqually
    }
    
    func createNumberButtons() {
        for i in 0...9 {
            let button = UIButton(type: .system)
            styleButton(button: button)
            button.setTitle("\(i)", for: .normal)
            button.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
            numberButtons.append(button)
        }
    }
    
    @objc func numberButtonTapped(sender: UIButton) {
        if let number = sender.titleLabel?.text {
            if (number == ".") {
                if (!isFloatingPoint) {
                    isFloatingPoint = true
                } else {
                    return
                }
            }
            valueLabel.text?.append(number)
        }
    }
    
}







