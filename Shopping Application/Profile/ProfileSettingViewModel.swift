//
//  ProfileSettingViewModel.swift
//  Shopping Application
//
//  Created by 김성률 on 7/9/24.
//

import Foundation

enum validationError: String, Error {
    case isNotLength = "2글자 이상 10글자 미만으로 입력해주세요."
    case isNotAt = "닉네임에 @는 포함할 수 없어요."
    case isNotHash = "닉네임에 #는 포함할 수 없어요."
    case isNotDollar = "닉네임에 $는 포함할 수 없어요."
    case isNotPercent = "닉네임에 %는 포함할 수 없어요."
    case isNotNumber = "닉네임에 숫자는 포함할 수 없어요."
    case isNotSpace = "닉네임에 공백은 포함할 수 없어요."
}

final class ProfileSettingViewModel {
    
    var inputText: Observable<String?> = Observable("")
    var outputText: Observable<String?> = Observable("")
    
    var allowed = Observable(false)
    
    init() {
        inputText.bind { value in
            self.validation()
        }
    }
    
    private func validation() {
        
        guard let inputText = inputText.value else { return }
        
        if inputText.count < 2 || inputText.count >= 10 {
            outputText.value = validationError.isNotLength.rawValue
            allowed.value = false
        } else if inputText.contains("@") {
            outputText.value = validationError.isNotAt.rawValue
            allowed.value = false
        } else if inputText.contains("#") {
            outputText.value = validationError.isNotHash.rawValue
            allowed.value = false
        } else if inputText.contains("$") {
            outputText.value = validationError.isNotDollar.rawValue
            allowed.value = false
        } else if inputText.contains("%") {
            outputText.value = validationError.isNotPercent.rawValue
            allowed.value = false
        } else if isDigit(input: inputText) {
            outputText.value = validationError.isNotNumber.rawValue
            allowed.value = false
        } else if inputText.contains(" ") {
            outputText.value = validationError.isNotSpace.rawValue
        } else {
            outputText.value = "사용할 수 있는 닉네임이에요"
            allowed.value = true
        }
    }
    
    private func isDigit(input: String) -> Bool {
        let decimalCharacters = CharacterSet.decimalDigits
        return input.rangeOfCharacter(from: decimalCharacters) != nil
    }
}
