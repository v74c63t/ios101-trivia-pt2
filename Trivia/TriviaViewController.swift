//
//  ViewController.swift
//  Trivia
//
//  Created by Mari Batilando on 4/6/23.
//

import UIKit

class TriviaViewController: UIViewController {
  
  @IBOutlet weak var currentQuestionNumberLabel: UILabel!
  @IBOutlet weak var questionContainerView: UIView!
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var answerButton0: UIButton!
  @IBOutlet weak var answerButton1: UIButton!
  @IBOutlet weak var answerButton2: UIButton!
  @IBOutlet weak var answerButton3: UIButton!
  
  private var questions = [TriviaQuestion]()
  private var currQuestionIndex = 0
  private var numCorrectQuestions = 0
    private var answerController:UIAlertController!
    
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addGradient()
    questionContainerView.layer.cornerRadius = 8.0
    // TODO: FETCH TRIVIA QUESTIONS HERE
    fetchData()
  }
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
    private func fetchData(){
        TriviaQuestionService.fetchQuestions(amount:5) { questions in
            
            self.configure(withQuestions: questions)
            }
    }
    
    private func configure(withQuestions triviaQuestions: [TriviaQuestion]){
        questions = triviaQuestions
        answerButton0.isHidden = true
        answerButton1.isHidden = true
        answerButton2.isHidden = true
        answerButton3.isHidden = true
        self.updateQuestion(withQuestionIndex: 0)
    }
  
  private func updateQuestion(withQuestionIndex questionIndex: Int) {
    currentQuestionNumberLabel.text = "Question: \(questionIndex + 1)/\(questions.count)"
      
    let question = questions[questionIndex]
      questionLabel.text = unescapeText(str: question.question)
      categoryLabel.text = unescapeText(str:question.category)
    let answers = ([question.correctAnswer] + question.incorrectAnswers).shuffled()
    if answers.count > 0 {
        answerButton0.setTitle(unescapeText(str:answers[0]), for: .normal)
        answerButton0.isHidden = false
    }
    if answers.count > 1 {
        answerButton1.setTitle(unescapeText(str:answers[1]), for: .normal)
      answerButton1.isHidden = false
    }
    if answers.count > 2 {
        answerButton2.setTitle(unescapeText(str:answers[2]), for: .normal)
      answerButton2.isHidden = false
    }
    if answers.count > 3 {
        answerButton3.setTitle(unescapeText(str:answers[3]), for: .normal)
      answerButton3.isHidden = false
    }
  }
  
  private func updateToNextQuestion(answer: String) {
      var title = ""
      var message = ""
      if isCorrectAnswer(answer) {
        numCorrectQuestions += 1
        title = "Correct!"
        message = "You got the question correct!"
      }
      else{
          title = "Wrong."
          message = "You got the question wrong."
          
      }
      answerController = UIAlertController(title: title,
                                              message: message,
                                              preferredStyle: .alert)
      present(answerController, animated: true, completion: nil)
      currQuestionIndex += 1
      guard self.currQuestionIndex < self.questions.count else {
          self.showFinalScore()
          return
      }
      sleep(1/4)
      answerController.dismiss(animated: false){
          self.answerButton0.isHidden = true
          self.answerButton1.isHidden = true
          self.answerButton2.isHidden = true
          self.answerButton3.isHidden = true
          self.updateQuestion(withQuestionIndex: self.currQuestionIndex)
      }
  }
  
  private func isCorrectAnswer(_ answer: String) -> Bool {
    return answer == questions[currQuestionIndex].correctAnswer
  }
  
  private func showFinalScore() {
      answerController.dismiss(animated: false){
          sleep(1/4)
          let alertController = UIAlertController(title: "Game over!",
                                                  message: "Final score: \(self.numCorrectQuestions)/\(self.questions.count)",
                                                  preferredStyle: .alert)
          let resetAction = UIAlertAction(title: "Restart", style: .default) { [unowned self] _ in
              currQuestionIndex = 0
              numCorrectQuestions = 0
              fetchData()
          }
          alertController.addAction(resetAction)
          self.present(alertController, animated: true, completion: nil)
          
      }
  }
  
  private func addGradient() {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = view.bounds
    gradientLayer.colors = [UIColor(red: 0.54, green: 0.88, blue: 0.99, alpha: 1.00).cgColor,
                            UIColor(red: 0.51, green: 0.81, blue: 0.97, alpha: 1.00).cgColor]
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
    gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
    view.layer.insertSublayer(gradientLayer, at: 0)
  }
  
  @IBAction func didTapAnswerButton0(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton1(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton2(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton3(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
}

