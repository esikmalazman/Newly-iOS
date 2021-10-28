//
//  TextAnalysisInteractor.swift
//  Newly
//
//  Created by Ikmal Azman on 25/10/2021.
//

import Foundation
import Vision

//MARK:- Recognize Text in Images , https://developer.apple.com/documentation/vision/recognizing_text_in_images/
final class TextAnalysisInteractor {
    
    func processImageToText(imageData : Data, completion : @escaping ((String)-> Void) ) {
        // Create a request to recognize text
        let request = VNRecognizeTextRequest { request, error in
           let textFilteringResults =  self.filterTextResults(request: request, error: error)
            completion(textFilteringResults)
        }
        request.recognitionLevel = .accurate
        request.usesCPUOnly = true
        request.usesLanguageCorrection = true
        request.recognitionLanguages = ["en-US","en-GB"]
        // Create image-request handler
        performRequest(imageData: imageData, with: request)
    }
    
    func filterTextResults(request : VNRequest, error : Error?) -> String {
        guard let textResults = request.results as? [VNRecognizedTextObservation] else {
            fatalError("Could not get the VNObservation results from request processing")
        }
        var recognizedText = ""
        // Iterate all results from text observation & get top candidates
        for textResult in textResults {
            // request top candidate for recognize strings
            if let topCandidate = textResult.topCandidates(1).first {
                recognizedText += topCandidate.string + "\n"
                print("Text : \(recognizedText)")
                print("Best candidates : \(topCandidate.string)")
                print("Confidence : \(topCandidate.confidence)")
            }
        }
        
        return recognizedText
    }
    
    private func performRequest(imageData : Data, with request : VNRecognizeTextRequest) {
        //let handler = VNImageRequestHandler(ciImage: ciImage)
        let handler  = VNImageRequestHandler(data:imageData)
        do {
            // Perform text recognition request
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
}
