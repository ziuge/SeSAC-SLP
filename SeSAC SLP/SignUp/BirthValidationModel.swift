//
//  BirthValidationModel.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/11.
//

import Foundation
import RxSwift
import RxCocoa

class BirthValidationModel {
    var validText = BehaviorRelay(value: "새싹 스터디는 만17세 이상만 사용할 수 있습니다.")
    
    struct Input {
        let birth: ControlProperty<Date>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let validation: Observable<Bool>
        let tap: ControlEvent<Void>
        let text: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        
        var registerableBirth = Calendar.current.date(byAdding: .year, value: -1, to: Date())!
        
        let valid = input.birth
            .map { $0 > registerableBirth }
        
        let text = validText.asDriver()
        
        return Output(validation: valid, tap: input.tap, text: text)
    }
}
