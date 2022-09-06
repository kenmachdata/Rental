//
//  ViewHelper.swift
//  Rental
//
//  Created by Kenneth Chatham on 9/6/22.
//

import SwiftUI

struct customViewModifier: ViewModifier {
    @Binding var focused: Bool
    var roundedCornes: CGFloat
    var startColor: Color
    var endColor: Color
    var textColor: Color
    var horizontalPad: CGFloat
    var verticalPad: CGFloat

    func body(content: Content) -> some View {
        content
//            .padding()
            .padding(.horizontal, horizontalPad)
            .padding(.vertical, verticalPad)
            .background( focused ? LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing) :
                            LinearGradient(gradient: Gradient(colors: [.gray, .gray]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(roundedCornes)
            
            .foregroundColor(textColor)
            .overlay(RoundedRectangle(cornerRadius: roundedCornes)
                .stroke(focused ? LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(gradient: Gradient(colors: [.gray, .gray]), startPoint: .topLeading, endPoint: .bottomLeading), lineWidth: 2.5))
            .font(.custom("Open Sans", size: 16))

            .shadow(radius: 5)
    }
}

struct MyTextFieldStyle: TextFieldStyle {
    @Binding var focused: Bool
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(focused ? Color.red : Color.gray, lineWidth: 3)
        ).padding(10)
    }
}



//public protocol TextFieldStyle {
//  associatedtype _Body: View
//  @ViewBuilder func _body(configuration: TextField<Self._Label>) -> Self._Body
//  typealias _Label = _TextFieldStyleLabel
//}
//
//
//struct FSTextFieldStyle: TextFieldStyle {
//  /// Whether the user is focused on this `TextField`.
//  var isEditing: Bool
//
//  func _body(configuration: TextField<_Label>) -> some View {
//    configuration
//      .textFieldStyle(PlainTextFieldStyle())
//      .multilineTextAlignment(.leading)
//      .accentColor(.pink)
//      .foregroundColor(.blue)
//      .font(.title.weight(.semibold))
//      .padding(.vertical, 12)
//      .padding(.horizontal, 16)
//      .background(border)
//  }
//
//  var border: some View {
//    RoundedRectangle(cornerRadius: 16)
//      .strokeBorder(
//        LinearGradient(
//          gradient: .init(
//            colors: [
//              Color(red: 163 / 255.0, green: 243 / 255.0, blue: 7 / 255.0),
//              Color(red: 226 / 255.0, green: 247 / 255.0, blue: 5 / 255.0)
//            ]
//          ),
//          startPoint: .topLeading,
//          endPoint: .bottomTrailing
//        ),
//        lineWidth: isEditing ? 4 : 2
//      )
//  }
//}
