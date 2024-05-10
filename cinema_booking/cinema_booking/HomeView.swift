//
//  HomeView.swift
//  cinema_booking
//
//  Created by 吴泓昕 on 5/8/24.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedCinema: String = "Choose Cinema"
    @State private var selectedDate = Date()
    
    // Demo wireframe
    let movies = [
        Movie(name: "Movie 1", poster: "poster1"),
        Movie(name: "Movie 2", poster: "poster2"),
        Movie(name: "Movie 3", poster: "poster3"),
        Movie(name: "Movie 4", poster: "poster4")
    ]

    var body: some View {
        VStack(spacing: 0) {
            CustomNavBarView // Nav Bar at the top
            
            CinemaPicker(
                selectedCinema: $selectedCinema,
                selectedDate: $selectedDate,
                cinemas: ["Choose Cinema", "Events - Broadway", "Pacific Cinema - Central Park", "Events - Town Hall", "Ritz - Randwick", "Dendy Cinema - Newtown"])
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(movies, id: \.name) { movie in
                        movieCard(for: movie)
                    }
                }
                .padding(.top, 20) //  add padding at the top
            }
        }
        .edgesIgnoringSafeArea(.top) // Extends the navbar to the top edge of the display
    }
    
    private func movieCard(for movie: Movie) -> some View {
        HStack {
            Image(movie.poster)
                .resizable()
                .scaledToFill()
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

struct Movie {
    let name: String
    let poster: String  // images name in assets
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

var CustomNavBarView: some View {
    VStack {
        HStack{
            //backButton
            Spacer()
            Text("Home")
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

