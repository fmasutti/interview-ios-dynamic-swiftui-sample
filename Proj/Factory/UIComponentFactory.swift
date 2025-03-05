//
//  UIComponentFactory.swift
//  InterviewTest
//
//  Created by Frantiesco Masutti on 28/02/2025.
//

import SwiftUI

struct UIFactory {

    @ViewBuilder
    static func createView(from component: ComponentModel,
                           bindings: [String: Binding<String>],
                           events: [String: EventModel],
                           parentFormEvent: String? = nil) -> some View {
        switch component.componentType {
        case .form(let formComponent):
            // When a form is found, pass its `onSubmit` to children
            createFormView(from: formComponent,
                           bindings: bindings,
                           events: events,
                           parentFormEvent: formComponent.onSubmit)

        case .container(let containerComponent):
            // Pass down the same parent form event
            createContainerView(from: containerComponent,
                                bindings: bindings,
                                events: events,
                                parentFormEvent: parentFormEvent)

        case .text(let textComponent):
            createTextView(from: textComponent)

        case .input(let inputComponent):
            createInputView(from: inputComponent, bindings: bindings)

        case .button(let buttonComponent):
            // Pass the parentFormEvent so the button knows if it's inside a form
            createButtonView(from: buttonComponent,
                             bindings: bindings,
                             events: events,
                             parentFormEvent: parentFormEvent)
        }
    }

    @ViewBuilder
    static func createFormView(from formComponent: FormComponentModel,
                               bindings: [String: Binding<String>],
                               events: [String: EventModel],
                               parentFormEvent: String?) -> some View {
        Form {
            VStack(spacing: CGFloat(formComponent.gap ?? 0)) {
                ForEach(formComponent.components, id: \.id) { subComponent in
                    AnyView(createView(from: subComponent, bindings: bindings, events: events, parentFormEvent: parentFormEvent))
                }
            }
        }.submitLabel(.done)
    }

    @ViewBuilder
    static func createContainerView(from containerComponent: ContainerComponentModel,
                                    bindings: [String: Binding<String>],
                                    events: [String: EventModel],
                                    parentFormEvent: String?) -> some View {
        VStack(spacing: CGFloat(containerComponent.gap ?? 0)) {
            ForEach(containerComponent.components, id: \.id) { subComponent in
                AnyView(createView(from: subComponent, bindings: bindings, events: events, parentFormEvent: parentFormEvent))
            }
        }
    }

    @ViewBuilder
    static func createTextView(from textComponent: TextComponentModel) -> some View {
        Text(textComponent.text)
    }

    @ViewBuilder
    static func createInputView(from inputComponent: InputComponentModel,
                                bindings: [String: Binding<String>]) -> some View {
        VStack(alignment: .leading) {
            Text(inputComponent.label)
                .font(.headline)

            TextField(inputComponent.hint, text: bindings[inputComponent.name] ?? .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 4)
        }
        .padding()
    }

    @ViewBuilder
    static func createButtonView(from buttonComponent: ButtonComponentModel,
                                 bindings: [String: Binding<String>],
                                 events: [String: EventModel],
                                 parentFormEvent: String?) -> some View {
        Button(action: {
            // Check if the button has its own event or inherits from the parent form
            var eventType = buttonComponent.type
            // Inherit the parent form event if it's a submit button
            if let parentFormEvent = parentFormEvent, buttonComponent.type.lowercased() == "submit"{
                eventType = parentFormEvent
            }
            
            if let event = events[eventType] {
                let eventHandler = EventHandler(bindings: bindings)
                eventHandler.handleEvent(event)
            }
        }, label: { Text(buttonComponent.text) })
        .padding()
    }
}

#Preview {
    let titleComponent = ComponentModel(componentType: .text(TextComponentModel(text: "Pay with Ducks")))
    let buttonComponent = ComponentModel(componentType: .button(ButtonComponentModel(type: "submit", text: "Submit")))
    let inputComponent = ComponentModel(componentType: .input(InputComponentModel(hint: "1234", label: "Duck Code", name: "duckCode")))
    let cotainerComponent = ComponentModel(componentType: .container(ContainerComponentModel(gap: 8, components: [titleComponent, buttonComponent, inputComponent])))
    let formComponent = ComponentModel(componentType: .form(FormComponentModel(gap: 8, onSubmit: "payWithDucks", components: [cotainerComponent])))
    
    return UIFactory.createView(from: formComponent,
                                bindings: ["duckCode": .constant("1234")],
                                events: ["PAY_WITH_DUCKS" : EventModel(type: "someEvent", actions: [ActionModel(type: ActionType.log, args: [ActionArgumentModel(key: "key", value: "some")])])])
}
