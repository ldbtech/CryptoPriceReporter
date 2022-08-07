//
//  KeyboardHandler.swift
//  BitcoinReporter
//
//  Created by Ali Daho on 8/2/22.
//
//
//  KeyboardHandler.swift
//  Weather app
//
//  Created by Ali Daho on 7/29/22.
//

import Combine
import SwiftUI
/**
 y default an ObservableObject synthesizes an objectWillChange publisher that emits the changed value before any
 of its @Published properties changes.
 **/
final class KeyboardHandler : ObservableObject{
    //padding will change accordingly.
    @Published private(set) var keyboardHeight : CGFloat = 0 // this is what we emit with our views
    
    private let keyboardShow = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .compactMap { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height }
    
    private let keyboardHide = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ in CGFloat.zero }
 
    // Merge both above together
    init(){
        _ = Publishers.Merge(keyboardShow, keyboardHide)
            .subscribe(on : DispatchQueue.main)
            .assign(to: \.self.keyboardHeight, on: self)
    }
}
