//
//  HomePagePresenter.swift
//  Newly
//
//  Created by Ikmal Azman on 26/10/2021.
//

import Foundation

protocol HomepagePresenterDelegate : AnyObject {
    func presentHistoryDetail(_ indexPath : IndexPath)
}

final class HomepagePresenter {
    
    private weak var delegate : HomepagePresenterDelegate?
    
    func setViewDelegate(delegate : HomepagePresenterDelegate) {
        self.delegate = delegate
    }
    
    func didTapRowAt(_ indexPath : IndexPath) {
        delegate?.presentHistoryDetail(indexPath)
    }
}
