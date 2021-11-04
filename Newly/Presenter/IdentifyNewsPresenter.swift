//
//  IdentifyNewsPresenter.swift
//  Newly
//
//  Created by Ikmal Azman on 26/10/2021.
//

import Foundation

protocol IdentifyNewsPresenterDelegate : AnyObject {
    func presentPredictions(_ text : String)
    func presentText(results : String)
}

final class IdentifyNewsPresenter {
    
    private weak var delegate : IdentifyNewsPresenterDelegate?
    private let textAnalystInteractor =  TextAnalysisInteractor()
    
    func setViewDelegate(delegate : IdentifyNewsPresenterDelegate) {
        self.delegate = delegate
    }
    
    func makePredictions(text : String) {
        if let results = textAnalystInteractor.predictText(text) {
         //   print("Results : \(results.capitalized)")
            delegate?.presentPredictions(results.capitalized)
        }
    }
    
    func analyseTextIn(image : Data) {
        textAnalystInteractor.processImageToText(imageData: image) { results in
            self.delegate?.presentText(results : results)
        }
    }
    
}
