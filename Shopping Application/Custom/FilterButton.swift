//
//  FilterButton.swift
//  Shopping Application
//
//  Created by 김성률 on 10/19/24.
//

import UIKit

final class FilterButton: UIButton {

    init(text: String, fontColor: UIColor = .black, backgroundColor: UIColor = .white) {
        super.init(frame: .zero)
        configureButton(text: text, fontColor: fontColor, backgroundColor: backgroundColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureButton(text: String, fontColor: UIColor, backgroundColor: UIColor) {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = backgroundColor
        configuration.baseForegroundColor = fontColor
        
        var attText = AttributedString(text)
        attText.font = UIFont.boldSystemFont(ofSize: CGFloat(14))
        configuration.attributedTitle = attText
        
        configuration.background.strokeColor = .lightGray
        configuration.background.strokeWidth = 1
        configuration.background.cornerRadius = 14
        
        self.configuration = configuration
    }
    
}
