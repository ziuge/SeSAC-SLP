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
    var validText = BehaviorRelay(value: "잘못된 전화번호 형식입니다.")
    
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
            .map { $0.count < 15 && $0.count > 9 }
            .share()
        
        let text = validText.asDriver()
        
        return Output(validation: valid, tap: input.tap, text: text)
    }
    
    func addHyphen(text: String) -> String {
        let text = text.withHyphen()
        return text
    }
}
