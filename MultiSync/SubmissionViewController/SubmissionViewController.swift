//
//  SubmissionViewController.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 10/6/23.
//

import UIKit

final class SubmissionViewController: UIViewController {
    
    private var viewModel: SubmissionViewModel!
    private var submissionListAdapter: SubmissionListAdapter?
    private let submissionTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SubmissionTableViewCell.self, forCellReuseIdentifier: "SubmissionTableViewCellID")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submissionListAdapter = SubmissionListAdapter(tableView: submissionTableView, dataSource: viewModel, delegate: self)
        
        view.addSubview(submissionTableView)
        
        submissionTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        submissionTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        submissionTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        submissionTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        submissionTableView.reloadData()
    }
    
    static func create(with viewModel: SubmissionViewModel) -> SubmissionViewController {
        let viewController = SubmissionViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
}

extension SubmissionViewController: SubmissionListDelegate {
    func addAction(at index: IndexPath) -> UIAction {
        let action = UIAction { action in
            print(index)
        }
        return action
    }
    
    func setEvent() -> UIControl.Event {
        let event: UIControl.Event = .touchUpInside
        return event
    }
}


final class SendViewController: UIViewController {
    
    private var submissions: [Submission] = [.init(title: "First", number: 0), .init(title: "Second", number: 1), .init(title: "Third", number: 2)]
    private let submissionTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SubmissionTableViewCell.self, forCellReuseIdentifier: "SubmissionTableViewCellID")
        return tableView
    }()
    private let viewModel: SendViewModel! = SendViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submissionTableView.delegate = self
        submissionTableView.dataSource = self
        
        view.addSubview(submissionTableView)
        
        submissionTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        submissionTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        submissionTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        submissionTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        submissionTableView.reloadData()
    }
    
    static func create() -> SendViewController {
        let viewController = SendViewController()
        return viewController
    }
    
    private func addAction(at indexPath: IndexPath) -> UIAction {
        let action = UIAction { action in
            let alertView = AlertView()
            let sendAction = UIAction { action in
                self.viewModel.postSomething(at: indexPath)
            }
            alertView.addSendButton(action: sendAction, for: .touchUpInside)
            self.present(alertView, animated: true)
        }
        return action
    }
    
    private func buttonEvent() -> UIControl.Event {
        return .touchUpInside
    }
    
}

extension SendViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return submissions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SubmissionTableViewCellID", for: indexPath) as? SubmissionTableViewCell else { return .init() }
        cell.apply(submissionCellViewModel: .init(title: submissions[indexPath.row].title, number: submissions[indexPath.row].number))
        cell.addSubmissionButton(action: addAction(at: indexPath), for: buttonEvent())
        return cell
    }
}

extension SendViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

final class AlertView: UIViewController {
    
    private let sendButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(sendButton)
        sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func addSendButton(action: UIAction, for event: UIControl.Event) {
        sendButton.addAction(action, for: event)
    }
    
}

final class SendViewModel {
    
    func postSomething(at index: IndexPath) {
        print(index)
    }
    
}
