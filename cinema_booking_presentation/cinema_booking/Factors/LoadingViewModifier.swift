import Foundation

import SwiftUI
//Loading animation
struct LoadingViewModifier: ViewModifier{
    @Binding  var showAlert: Bool
    @Binding var msg: String
    func body(content: Content) -> some View {
        content.overlay(
            VStack(spacing: 20) {
                Text(msg)
                    .foregroundColor(.white)
            }
                .frame(width: 150,height:100)
                .padding(.horizontal, 15)
                .background(Color(white: 0, opacity: 0.8))
                
                .cornerRadius(20)
                .opacity(showAlert ? 1 : 0) //
                .offset(y:-80)
            
        )
    }
}
extension View {
    func withLoading(showAlert: Binding<Bool>, msg: Binding<String>) -> some View {
        modifier(LoadingViewModifier(showAlert: showAlert, msg: msg))
    }
}
