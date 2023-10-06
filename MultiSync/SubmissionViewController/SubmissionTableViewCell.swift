//
//  SubmissionTableViewCell.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 10/6/23.
//

import UIKit

final class SubmissionTableViewCell: UITableViewCell {
    
    private let submissionTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Submission"
        return label
    }()
    private let submissionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submission", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "SubmissionTableViewCellID")
        contentView.addSubview(submissionTitle)
        contentView.addSubview(submissionButton)
        setSubmissionTitleLayout()
        setSubmissionButtonLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func apply(submissionCellViewModel: SubmissionCellViewModel) {
        submissionTitle.text = submissionCellViewModel.title
        submissionButton.setTitle(String(submissionCellViewModel.number), for: .normal)
    }
    
    private func setSubmissionTitleLayout() {
        submissionTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        submissionTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    private func setSubmissionButtonLayout() {
        submissionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        submissionButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    func addSubmissionButton(action: UIAction, for event: UIControl.Event) {
        submissionButton.addAction(action, for: event)
    }

}

struct SubmissionCellViewModel {
    let title: String
    let number: Int
}

extension UIButton {
    func addAction(at index: IndexPath, action: UIAction, for control: UIControl.Event) -> IndexPath {
        addAction(action, for: control)
        return index
    }
}
