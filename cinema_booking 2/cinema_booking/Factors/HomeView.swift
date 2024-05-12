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
        Movie(name: "Dune 2", poster: "poster1"),
        Movie(name: "Movie 2", poster: "poster2"),
        Movie(name: "Movie 3", poster: "poster3"),
        Movie(name: "Movie 4", poster: "poster4")
    ]

    var body: some View {
            NavigationView {
                VStack(spacing: 0) {
                    CustomNavBarView

                    CinemaPicker(
                        selectedCinema: $selectedCinema,
                        selectedDate: $selectedDate,
                        cinemas: ["选择影院", "Events - Broadway", "Pacific Cinema - Central Park", "Events - Town Hall", "Ritz - Randwick", "Dendy Cinema - Newtown"])
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(movies, id: \.name) { movie in
                                movieCard(for: movie)
                            }
                        }
                        .padding(.top, 20)
                    }
                }
                .edgesIgnoringSafeArea(.top)
            }
        }
        
        private func movieCard(for movie: Movie) -> some View {
            NavigationLink(destination: MovieDetailView(movie: movie)) {
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
    }

    struct Movie {
        let name: String
        let poster: String
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

struct MovieDetailView: View {
    let movie: Movie
    
    @State private var selectedDateIndex = 0
    @State private var selectedTimeIndex = -1
    @State private var showFullDescription = false
    
    // These are placeholders for the movie details and ratings
    private let movieDescription = "Dune: Part Two is a 2024 American epic science fiction film directed and produced by Denis Villeneuve, who co-wrote the screenplay with Jon Spaihts."
    private let movieRating = "8.5/10"
    
    // This function generates the next 7 days including today
    private var dateOptions: [(String, String, String)] {
        let calendar = Calendar.current
        return (0..<7).map { i in
            let date = calendar.date(byAdding: .day, value: i, to: Date())!
            let day = calendar.component(.day, from: date)
            let weekday = calendar.weekdaySymbols[calendar.component(.weekday, from: date) - 1]
            let month = calendar.shortMonthSymbols[calendar.component(.month, from: date) - 1]
            return (String(day), weekday, month)
        }
    }
    
    private let timeOptions = [
        "10:00", "12:35", "14:00", "15:55", "18:15", "21:30", "23:05"
    ]
    
    private var availableTimeOptions: [String] {
        let currentTime = Calendar.current.dateComponents([.hour, .minute], from: Date())
        let currentHour = currentTime.hour ?? 0
        let currentMinute = currentTime.minute ?? 0
        
        return timeOptions.filter { timeString in
            let components = timeString.components(separatedBy: ":")
            guard components.count == 2,
                  let hour = Int(components[0]),
                  let minute = Int(components[1]) else {
                return false
            }
            
            // Only allow times that are in the future compared to the current time
            return hour > currentHour || (hour == currentHour && minute > currentMinute)
        }
    }
    
    var body: some View {
        VStack {
            Image(movie.poster)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400, height: 250)
            
            ScrollView {
                VStack(spacing: 5) {
                    Text(movie.name)
                        .font(.title)
                        .fontWeight(.heavy)
                    Text("Rate: \(movieRating)")
                        .font(.caption)
                    
                    Text("About film")
                        .font(.title3)
                        .fontWeight(.bold)
                    if showFullDescription {
                        Text(movieDescription)
                            .foregroundColor(.secondary)
                            .transition(.opacity)
                        Button("Read Less") {
                            withAnimation {
                                showFullDescription.toggle()
                            }
                        }
                        .foregroundColor(.blue)
                    } else {
                        Text(movieDescription)
                            .lineLimit(2)
                            .foregroundColor(.secondary)
                        Button("Read More") {
                            withAnimation {
                                showFullDescription.toggle()
                            }
                        }
                        .foregroundColor(.blue)
                    }
                    Divider()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 18) {
                            ForEach(0..<dateOptions.count, id: \.self) { index in
                                VStack {
                                    Text(dateOptions[index].1)
                                        .font(.subheadline)
                                    Text(dateOptions[index].0)
                                        .font(.title)
                                    Text(dateOptions[index].2)
                                        .font(.footnote)
                                }
                                .padding(10)
                                .background(index == selectedDateIndex ? Color.blue.opacity(0.3) : Color.gray.opacity(0.3))
                                .cornerRadius(10)
                                .onTapGesture {
                                    selectedDateIndex = index
                                }
                            }
                        }
                    }
                    Divider()
                    
                    Text("Available Times")
                        .font(.headline)
                        .padding(.top)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(availableTimeOptions, id: \.self) { time in
                            Button(action: {
                                selectedTimeIndex = availableTimeOptions.firstIndex(of: time)!
                            }) {
                                Text(time)
                                    .foregroundColor(selectedTimeIndex == availableTimeOptions.firstIndex(of: time)! ? .black : .black.opacity(0.7))
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(selectedTimeIndex == availableTimeOptions.firstIndex(of: time)! ? Color.blue.opacity(0.3) : Color.gray.opacity(0.3))
                                    .cornerRadius(10)
                            }
                        }
                    }
                    NavigationLink(destination: SeatSelectionView()) {
                        Button("Next") {
                            // Implement the next button action here
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedTimeIndex != -1 ? Color.blue : Color.gray)
                        .cornerRadius(10)
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }
    
    struct MovieDetailView_Previews: PreviewProvider {
        static var previews: some View {
            MovieDetailView(movie: Movie(name: "Dune 2", poster: "poster1"))
        }
    }
}
