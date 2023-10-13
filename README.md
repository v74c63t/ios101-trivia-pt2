# Project 4 - *Trivia*

Submitted by: **Vanessa Tang**

**Trivia** is an app that shows the users a set of questions obtained from the OpenTriviaDB API that can be answered in succession. It keeps track of the amount of questions left and the current question the user is on. After an user answers a question, it will display an alert briefly to show them if they answered the question correctly or not before moving on to the next question. When all the questions are answered, it will display to the users the amount of questions they answered correctly out of all the questions. Lastly, the user has an option to restart and a new set of questions will be obtained from the API

Time spent: **9** hours spent in total

## Required Features

The following **required** functionality is completed:

- [x] User can view and answer at least 5 trivia questions.
- [x] App retrieves question data from the Open Trivia Database API.
- [x] Fetch a different set of questions if the user indicates they would like to reset the game.
- [x] Users can see score after submitting all questions.
- [x] True or False questions only have two options.


The following **optional** features are implemented:

  
- [ ] Allow the user to choose a specific category of questions.
- [x] Provide the user feedback on whether each question was correct before navigating to the next.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

## Video Walkthrough

<!--Here is a reminder on how to embed Loom videos on GitHub. Feel free to remove this reminder once you upload your README. 

[Guide]](https://www.youtube.com/watch?v=GA92eKlYio4) .-->
<img src='walkthrough.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Notes

Describe any challenges encountered while building the app.

- I had issues with decoding some of the data returned from the API. It took me a while to figure out how to fix the unescaped characters/unicode errors in the text.

## License

    Copyright [2023] [Vanessa Tang]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
