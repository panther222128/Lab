//
//  EnumViewController.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/09/27.
//

import UIKit
import Combine

final class EnumViewController: UIViewController {
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let numberButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Change Number", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    private let clearNumberButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Clear Number", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    private let viewModel: EnumViewModel = DefaultEnumViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(numberLabel)
        view.addSubview(numberButton)
        view.addSubview(clearNumberButton)
        
        numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        numberLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        numberButton.topAnchor.constraint(equalTo: numberLabel.bottomAnchor).isActive = true
        numberButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        clearNumberButton.topAnchor.constraint(equalTo: numberButton.bottomAnchor).isActive = true
        clearNumberButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        subscribe(number: viewModel.numberPublisher)
        
        addChangeNumberButtonAction()
        addClearNumberButtonAction()
    }
    
    private func subscribe(number: AnyPublisher<Int, Never>) {
        viewModel.numberPublisher
            .sink { [weak self] value in
                self?.numberLabel.text = String(value)
            }
            .store(in: &cancellables)
    }
    
    private func addChangeNumberButtonAction() {
        numberButton.addTarget(self, action: #selector(didPressedChangeNumberButton), for: .touchUpInside)
    }
    
    private func addClearNumberButtonAction() {
        clearNumberButton.addTarget(self, action: #selector(didPressedClearNumberButton), for: .touchUpInside)
    }
    
    @objc private func didPressedChangeNumberButton(_ sender: UIButton) {
        viewModel.perform(action: .didChangeNumber(100))
    }
    
    @objc private func didPressedClearNumberButton(_ sender: UIButton) {
        viewModel.perform(action: .didClearNumber)
    }
    
}
