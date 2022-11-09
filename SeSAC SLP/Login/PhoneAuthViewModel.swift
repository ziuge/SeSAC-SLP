//
//  PhoneAuthViewModel.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/08.
//

import RxSwift
import RxCocoa
import Foundation

class PhoneAuthViewModel {
    let validText = BehaviorRelay(value: "유효한 전화번호")
    
    struct Input {
        let number: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let validation: Observable<Bool>
        let tap: ControlEvent<Void>
        let text: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        let valid = input.number
            .orEmpty
            .map { $0.count < 12 && $0.count > 9 }
            .share()
        
        let text = validText.asDriver()
        
        return Output(validation: valid, tap: input.tap, text: text)
    }
    
}
