//
//  EnumViewModel.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/09/27.
//

import Foundation
import Combine

protocol EnumViewModel {
    var numberPublisher: AnyPublisher<Int, Never> { get }
    
    func perform(action: DefaultEnumViewModel.EnumViewModelAction)
}

final class DefaultEnumViewModel: EnumViewModel {
    
    enum EnumViewModelAction {
        case didClearNumber
        case didChangeNumber(Int)
        case didChangeNumberWithOption(Int, Int)
    }
    
    private var number: Int = 0
    private let numberSubject: CurrentValueSubject<Int, Never> = .init(0)
    var numberPublisher: AnyPublisher<Int, Never> {
        return numberSubject.eraseToAnyPublisher()
    }
    
    init() {
        
    }
    
    func perform(action: EnumViewModelAction) {
        switch action {
        case .didClearNumber:
            number = 0
            numberSubject.send(number)
            
        case .didChangeNumber(let int):
            number = int
            numberSubject.send(number)
            
        case .didChangeNumberWithOption(let first, let second):
            number = first
            numberSubject.send(number)
            
        }
    }
    
}
