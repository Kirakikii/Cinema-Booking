//
//  BookingsView.swift
//  cinema_booking
//
//  Created by 吴泓昕 on 5/8/24.
//

import SwiftUI



struct TicketsView: View {
    // Demo wireframe
    let movies = [
        Movies(name: "Movie 1", poster: "poster1"),
        Movies(name: "Movie 2", poster: "poster2"),
        Movies(name: "Movie 3", poster: "poster3"),
        Movies(name: "Movie 4", poster: "poster4")
    ]
    
    var body: some View {
        VStack (spacing:0){
            TicketsNavBarView
            
            ScrollView {
                VStack {
                    ForEach(movies, id: \.name) { movie in
                        HStack {
                            Image(movie.poster)
                                .resizable()
                                .frame(width: 100, height: 150)
                                .cornerRadius(8)
                                .padding()
                            
                            Text(movie.name)
                                .font(.headline)
                                .padding()
                            
                            Spacer()
                        }
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.top, 20)
            .navigationBarHidden(true)
        }
        .edgesIgnoringSafeArea(.top)
    }
}
    
        
        

struct Movies {
    let name: String
    let poster: String  // Assume you have images named "poster1", "poster2", etc., in your assets
}

struct TicketsView_Previews: PreviewProvider {
    static var previews: some View {
        TicketsView()
    }
}

var TicketsNavBarView: some View {
    VStack {
        HStack{
            //backButton
            Spacer()
            Text("Tickets")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 40)
            Spacer()
            //backButton.opacity(0) //keep the title centred
        }
        //.padding()
        .padding(.vertical, 25)
        .padding(.bottom, 0)
        .background(Color.indigo)
    }
}
