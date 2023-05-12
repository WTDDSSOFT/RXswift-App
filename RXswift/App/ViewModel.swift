//
//  ViewModel.swift
//  RXswift
//
//  Created by william torres dias dos santos on 06/05/23.
//

import Foundation

protocol ViewModel {

    associatedtype Input
    associatedtype Output

    func bind(input: Input) -> Output

}
