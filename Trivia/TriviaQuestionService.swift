//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Vanessa Tang on 10/12/23.
//

import Foundation
class TriviaQuestionService{
    static func fetchQuestions(amount: Int, category: Int?, difficulty: String?, type: String?, completion: (([TriviaQuestion]) -> Void)? = nil){
        let base = "https://opentdb.com/api.php?"
        var params = "amount=\(amount)"
        let url = URL(string: base+params)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
              // this closure is fired when the response is received
              guard error == nil else {
                assertionFailure("Error: \(error!.localizedDescription)")
                return
              }
              guard let httpResponse = response as? HTTPURLResponse else {
                assertionFailure("Invalid response")
                return
              }
              guard let data = data, httpResponse.statusCode == 200 else {
                assertionFailure("Invalid response status code: \(httpResponse.statusCode)")
                return
              }
              // at this point, `data` contains the data received from the response
                let questions = parse(data: data)
              // this response will be used to change the UI, so it must happen on the main thread
                DispatchQueue.main.async {
                completion?(questions) // call the completion closure and pass in the forecast data model
              }
            }
            task.resume() // resume the task and fire the request
    }
    private static func parse(data: Data) ->[TriviaQuestion] {
        return []
    }
}
