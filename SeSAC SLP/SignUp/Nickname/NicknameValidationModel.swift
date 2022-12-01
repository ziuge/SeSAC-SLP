//
//  NicknameValidationModel.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/11.
//

import Foundation
import RxSwift
import RxCocoa

class NicknameValidationModel {
    var validText = BehaviorRelay(value: "닉네임은 1자 이상 10자 이내로 부탁드려요.")
    
    struct Input {
        let nick: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let validation: Observable<Bool>
        let tap: ControlEvent<Void>
        let text: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        let valid = input.nick
            .orEmpty
            .map { $0.count >= 1 && $0.count <= 10 }
            .share()
        
        let text = validText.asDriver()
        
        return Output(validation: valid, tap: input.tap, text: text)
    }
    
}
