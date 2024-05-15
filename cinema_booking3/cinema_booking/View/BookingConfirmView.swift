//
//  BookingConfirmView.swift
//  cinema_booking
//
//  Created by 吴泓昕 on 5/10/24.
//

import SwiftUI

struct BookingConfirmView: View {
    @EnvironmentObject var globalViewModel: GlobalViewModel
    var body: some View {
        VStack{
            ConfirmNavBarView
            
            Spacer()
            
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width:100, height:100)
                .foregroundColor(.green)
            
            Text("Your booking is confirmed")
                .font(.title)
                .padding()
            
            Spacer()
         

            NavigationLink(destination: TicketsView()){
                Text("Go to 'Tickets'")
                    .foregroundColor(.white)
                    .padding(20)
                    .font(.headline)
                    .padding(.horizontal, 60)
                    .background(Color.indigo)
                    .cornerRadius(10)
            }
            .padding(.bottom, 40)
            
            
            
        }
        .navigationBarHidden(true)
        .toolbar(.hidden, for: .tabBar)
    }
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

var backButton: some View{
    Button(action:{
        //action for back button - back to previous screen
    }){
        Image(systemName: "chevron.left")
            .foregroundColor(.white)
            .padding(10)
    }

    
}

struct BookingConfirmView_Previews: PreviewProvider{
    static var previews: some View{
        NavigationView{
            BookingConfirmView()
        }
    }
}
