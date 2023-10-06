//
//  SubmissionListAdapter.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 10/6/23.
//

import UIKit

protocol SubmissionListDataSource: AnyObject {
    func numberOfCell() -> Int
    func cellForItem(at indexPath: IndexPath) -> SubmissionCellViewModel
}

protocol SubmissionListDelegate: AnyObject {
    func addAction(at index: IndexPath) -> UIAction
    func setEvent() -> UIControl.Event
}

final class SubmissionListAdapter: NSObject {
    
    private let tableView: UITableView
    weak var dataSource: SubmissionListDataSource?
    weak var delegate: SubmissionListDelegate?
    
    init(tableView: UITableView, dataSource: SubmissionListDataSource? = nil, delegate: SubmissionListDelegate? = nil) {
        self.tableView = tableView
        self.dataSource = dataSource
        self.delegate = delegate
        super.init()
        
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension SubmissionListAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.numberOfCell() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SubmissionTableViewCellID", for: indexPath) as? SubmissionTableViewCell else { return .init() }
        guard let cellViewModel = dataSource?.cellForItem(at: indexPath) else { return .init() }
        cell.apply(submissionCellViewModel: cellViewModel)
        guard let action = delegate?.addAction(at: indexPath) else { return .init() }
        guard let event = delegate?.setEvent() else { return .init() }
        cell.addSubmissionButton(action: action, for: event)
        return cell
    }
}

extension SubmissionListAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

