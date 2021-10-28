//
//  IdentifyNewsPresenter.swift
//  Newly
//
//  Created by Ikmal Azman on 26/10/2021.
//

import Foundation

protocol IdentifyNewsPresenterDelegate : AnyObject {}

final class IdentifyNewsPresenter {
    
    private weak var delegate : IdentifyNewsPresenterDelegate?
    private var sourceType : String?
    
    func setViewDelegate(delegate : IdentifyNewsPresenterDelegate) {
        self.delegate = delegate
    }
    
}
