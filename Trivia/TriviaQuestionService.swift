//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Vanessa Tang on 10/12/23.
//

import Foundation

class TriviaQuestionService{
    static func fetchQuestions(amount: Int, completion: (([TriviaQuestion]) -> Void)? = nil){
        let base = "https://opentdb.com/api.php?"
        let params = "amount=\(amount)"
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

            let questions = parse(data: data)
            DispatchQueue.main.async {
            completion?(questions)
          }
            let decoder = JSONDecoder()
            let response = try! decoder.decode(TriviaAPIResponse.self, from: data)
            DispatchQueue.main.async {
                completion?(response.results)
            }

        }
            task.resume() // resume the task and fire the request
    }
    private static func parse(data: Data) ->[TriviaQuestion] {
        var triviaQuestions = [TriviaQuestion]()
        let jsonDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        let questions = jsonDictionary["results"] as! [AnyObject]
        for q in questions {
            let category =  q["category"] as! String
            let question =  (q["question"] as! String)
            let correctAnswer =  q["correct_answer"] as! String
            let incorrectAnswers = q["incorrect_answers"] as! [String]

            triviaQuestions.append(TriviaQuestion(category: category, question: question, correctAnswer: correctAnswer, incorrectAnswers: incorrectAnswers))
        }
        return triviaQuestions
    }
}
