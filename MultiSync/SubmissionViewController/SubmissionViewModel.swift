//
//  SubmissionViewModel.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 10/6/23.
//

import Foundation
import Combine

protocol SubmissionViewModel: SubmissionListDataSource {
    
}

final class DefaultSubmissionViewModel: SubmissionViewModel {
    
    private let submissions: [Submission]
    private let submissionsSubject: CurrentValueSubject<[Submission], Never>
    
    init(submissions: [Submission]) {
        self.submissions = submissions
        self.submissionsSubject = .init(self.submissions)
    }
    
}

extension DefaultSubmissionViewModel {
    func numberOfCell() -> Int {
        return submissions.count
    }
    
    func cellForItem(at indexPath: IndexPath) -> SubmissionCellViewModel {
        return .init(title: submissions[indexPath.row].title, number: submissions[indexPath.row].number)
    }
}
