//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Vanessa Tang on 10/12/23.
//

import Foundation
private func unescapeText(str:String) -> String {
    guard let utf = str.data(using: .utf8) else{return str}
    guard let attributedString = try? NSAttributedString(
      data: utf,
      options: [
        .documentType: NSAttributedString.DocumentType.html,
        .characterEncoding: String.Encoding.utf8.rawValue
      ],
      documentAttributes: nil
    )
    else {
      return str
    }
    return attributedString.string
}
class TriviaQuestionService{
    static func fetchQuestions(amount: Int, category: Int? = nil, difficulty: String? = nil, type: String? = nil, completion: (([TriviaQuestion]) -> Void)? = nil){
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
            let decoder = JSONDecoder()
            let response = try! decoder.decode(TriviaAPIResponse.self, from: data)
            DispatchQueue.main.async {
                completion?(response.results)
            }
            
//            var triviaQuestions = [TriviaQuestion]()
//            for question in response.results {
//                triviaQuestions.append(TriviaQuestion(category: category, question: question, correctAnswer: correctAnswer, incorrectAnswers: incorrectAnswers))
//            }
              // this response will be used to change the UI, so it must happen on the main thread
                DispatchQueue.main.async {
                completion?(questions) // call the completion closure and pass in the forecast data model
              }
            }
            task.resume() // resume the task and fire the request
    }
    private static func parse(data: Data) ->[TriviaQuestion] {
        var triviaQuestions = [TriviaQuestion]()
        let jsonDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        let questions = jsonDictionary["results"] as! [AnyObject]
        for q in questions {
            let category = unescapeText(str: q["category"] as! String)
            let question = unescapeText(str: (q["question"] as! String))
            let correctAnswer = unescapeText(str: q["correct_answer"] as! String)
            var incorrectAnswers = [String]()
            for incorrectAnswer in q ["incorrect_answers"] as! [String]{
                incorrectAnswers.append(unescapeText(str: incorrectAnswer))
            }

            triviaQuestions.append(TriviaQuestion(category: category, question: question, correctAnswer: correctAnswer, incorrectAnswers: incorrectAnswers))
        }
        return triviaQuestions
    }
}
