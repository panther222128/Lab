//
//  AssignViewController.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/09/25.
//

import UIKit
import Combine

protocol AssignUseCase {
    
}

final class DefaultAssignUseCase: AssignUseCase {
    
    init() {
        
    }
    
}

protocol AssignViewModel {
    var numberPublisher: AnyPublisher<Int, Never> { get }
}

final class DefaultAssignViewModel: AssignViewModel {
    
    private var number: Int = 0
    private let numberSubject: CurrentValueSubject<Int, Never> = .init(0)
    var numberPublisher: AnyPublisher<Int, Never> {
        return numberSubject.eraseToAnyPublisher()
    }
    
    init() {
        
    }
    
}

final class AssignViewController: UIViewController {
    
    private let viewModel: AssignViewModel = DefaultAssignViewModel()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let nameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Set name", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(nameLabel)
        view.addSubview(nameButton)
        
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        nameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        
        nameButton.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)
    }
    
    private func subscribe(number: AnyPublisher<Int, Never>) {

    }
    
    @objc func didPressButton(_ sender: UIButton) {
        print("OEA SM")
        createConnectable()
    }
    
    private var cancellable: AnyCancellable = .init {
        return
    }
    private var secondCancellable: AnyCancellable = .init {
        return
    }
    
    private func createConnectable() {
        let url = URL(string: "https://544a9ef9-2c3c-441a-824b-97788c0761e8.mock.pstmn.io/omgtest/main/group") ?? .init(filePath: "")
        let connectable = URLSession.shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .catch { _ in Just(Data()) }
            .share()
            .makeConnectable()
        cancellable = connectable
            .sink(receiveValue: { [weak self] value in
                print("Recive \(value.count)")
            })
        
        secondCancellable = connectable
            .sink(receiveValue: { [weak self] value in
                print("Also \(value.count)")
            })
    }
    
}
