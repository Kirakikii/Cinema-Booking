//
//  BookingConfirmView.swift
//  cinema_booking
//
//  Created by 吴泓昕 on 5/10/24.
//

import SwiftUI

struct BookingConfirmView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    BookingConfirmView()
}

var ConfirmNavBarView: some View {
    VStack {
        HStack{
            //backButton
            Spacer()
            //Text("Seat Selection")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Spacer()
            //backButton.opacity(0) //keep the title centred
        }
        .padding()
        .padding(.horizontal, 40)
        .background(Color.indigo)
    }
}
