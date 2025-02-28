# iOS Integration Engineer Pair Programming Challenge

Welcome to my repository for the iOS Integration Engineer Pair Programming Challenge. This README file provides an overview of the challenge, along with an explanation of my approach and code.

## Challenge Description

The goal of this exercise is to:
1. Consume the JSON schema provided.
2. Render the UI elements (Form, Container, Text, Input, Button).
3. Collect the required data.
4. When the Form is submitted, trigger the specified event `PAY_WITH_DUCKS`.
5. When `PAY_WITH_DUCKS` is triggered, execute the corresponding action log, which will simply print the value to the console.

### Duck Coin 🦆

“Duck Coin” is a simple payment method that only requires the user to enter their Duck Code number before clicking “Pay”.

Here’s a JSON file that describes the UI and logic of the “Duck Coin” payment method:

```json
{
  "screens": [
    {
      "id": "start-screen",
      "components": [
        {
          "componentType": "Form",
          "gap": 4,
          "onSubmit": "PAY_WITH_DUCKS",
          "components": [
            {
              "componentType": "Container",
              "gap": 2,
              "components": [
                {
                  "componentType": "Text",
                  "text": "Pay with Ducks"
                },
                {
                  "componentType": "Text",
                  "text": "1. Go to your Ducks app to get your Duck code."
                },
                {
                  "componentType": "Text",
                  "text": "2. Paste your Duck code here."
                },
                {
                  "componentType": "Input",
                  "hint": "1234",
                  "label": "Duck code",
                  "name": "duckCode"
                }
              ]
            },
            {
              "componentType": "Button",
              "type": "submit",
              "text": "Pay"
            }
          ]
        }
      ]
    }
  ],
  "events": [
    {
      "type": "PAY_WITH_DUCKS",
      "actions": [
        {
          "type": "log",
          "args": [
            {
              "duckCode": "{{duckCode}}"
            }
          ]
        }
      ]
    }
  ]
}
```


The schema consists of two blocks:
- `screens`: Contains all of the components that should be used to render the screen, and also potential events they may trigger.
- `events`: Contains a list of events that specify which actions to execute when they trigger.

## My Approach

In this section, I will describe my approach to solving the challenge. This includes my thought process, design decisions, and code implementation details.

### Project Setup

- Created a new SwiftUI project in Xcode.
- Configured project settings and added necessary dependencies.

### Model

- Defined the data model structures based on the JSON schema.
- Created `AppModel`, `ScreenModel`, `ComponentModel`, `ActionModel`, `ArgModel`, and `EventModel` models to represent the JSON data.
- Used Swift's `Codable` protocol to parse the JSON data into these model structures.
- Ensured that the model accurately reflects the nested structure of the JSON, including components within components.

### UI Implementation

- The UI of the app is dynamically created based on the `data.json` file, which serves as a "mocked" response from an external service.
- Followed the MVVM (Model-View-ViewModel) pattern, which is the pattern I'm most comfortable working with.
- Created the `renderComponent` function directly within the view itself to speed up the process for the test.
  
### API Integration

- Integrated with the local `data.json` file to mimic an external API.
- Created a `DuckCoinAPIService` class that pretends to access some external API using `URLSession` OR `Alamofire` but at end it just access the local `data.json`.
- Parsed the JSON data using `Codable` structures All those model was created by AI.
- Displayed the fetched data in the SwiftUI views.

### State Management

- Used `@State` properties to manage local state within views.
- Implemented an `ObservableObject` class to manage shared state across views.
- Bound the state to the UI using property wrappers like `@Published`.

## Branches

- **InterviewResult**: This branch contains the code I wrote during the interview process. The test took 1 hour.
  - **IMPORTANT**: Look for the `// FIXME: (JUST SWAP THE "componentType" TO id)` comments. There are 2 incidences in the project where this makes a significant difference in the final result. I didn't catch these during the test as I was really nervous.
- **Main**: This branch includes minor improvements made after completing the solution with the company.

### AI Assistance

- During this test, I was able to use the AI to speed up the process. I used Copilot over the installed version on my Xcode to assist with coding tasks.

## Conclusion

In this challenge, I demonstrated my skills in SwiftUI, API integration, state management, and error handling. The resulting application is dynamic, responsive, and handles external data effectively.

## Repository Link

You can find my code implementation and additional details in this repository: [iOS Dynamic SwiftUI Sample](https://github.com/fmasutti/interview-ios-dynamic-swiftui-sample)

Feel free to explore the code and reach out if you have any questions or feedback!
