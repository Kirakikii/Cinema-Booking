//
//  FilmDetailView.swift
//  cinema_booking
//
//  Created by 吴泓昕 on 5/13/24.
//

import SwiftUI

struct MovieDetailView: View {
    let film: Film
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewRouter: ViewRouter
    
    @State private var selectedDateIndex = 0
    @State private var selectedTimeIndex = -1
    @State private var showFullDescription = false
    @State var showSeatSelectionView = false
    @State var selectedDate = Date()
    @State var selectedTime = ""
    
    // This function generates the next 7 days including current day
    private var dateOptions: [(String, String, String)] {
        let calendar = Calendar.current
        return (0..<7).map { i in
            let date = calendar.date(byAdding: .day, value: i, to: Date())!
            let day = calendar.component(.day, from: date)
            let weekday = calendar.shortWeekdaySymbols[calendar.component(.weekday, from: date) - 1]
            let month = calendar.shortMonthSymbols[calendar.component(.month, from: date) - 1]
            return (String(day), weekday, month)
        }
    }
    private let timeOptions = [
        "10:00", "12:35", "14:00", "15:55", "18:15", "21:30", "23:59"
    ]
    
    
    
    // Retrieves the users exact time and minute, ensuring booking cant be made after sessions is expired
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
            
            Image(film.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400, height: 250)
                .padding(.top, 0)
            // User scroll view to show film details before booking
            ScrollView {
                VStack(spacing: 5) {
                    Text(film.filmName)
                        .font(.title)
                        .fontWeight(.heavy)
                    Text("Duration: \(film.duration)")
                        .font(.caption)
                    
                    Text("About Film")
                        .font(.title3)
                        .fontWeight(.bold)
                    if showFullDescription {
                        Text(film.description)
                            .foregroundColor(.secondary)
                            .transition(.opacity)
                        Button("Read Less") {
                            withAnimation {
                                showFullDescription.toggle()
                            }
                        }
                        .foregroundColor(.pink)
                    } else {
                        Text(film.description)
                            .lineLimit(2)
                            .foregroundColor(.secondary)
                        Button("Read More") {
                            withAnimation {
                                showFullDescription.toggle()
                            }
                        }
                        .foregroundColor(.pink)
                    }
                    Divider()
                    // Scroll view to show current date and time
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
                                .background(index == selectedDateIndex ? Color.indigo.opacity(0.3) : Color.gray.opacity(0.3))
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
                                selectedTime = time
                            }) {
                                Text(time)
                                    .foregroundColor(selectedTimeIndex == availableTimeOptions.firstIndex(of: time)! ? .black : .black.opacity(0.7))
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(selectedTimeIndex == availableTimeOptions.firstIndex(of: time)! ? Color.pink.opacity(0.3) : Color.indigo.opacity(0.3))
                                    .cornerRadius(10)
                            }
                        }
                    }
                    Button {
                        viewRouter.showTabBar = false
                        showSeatSelectionView = true
                    } label: {
                        Text("Next")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(selectedTimeIndex != -1 ? Color.indigo : Color.gray)
                            .cornerRadius(10)
                    }
                    
                }
                .padding()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                dismiss()
                viewRouter.showTabBar = true
            }) {
                Image(systemName: "chevron.left")
                // Sets the color of the back button to pink
                    .foregroundColor(.pink)
            })
            .onAppear {
                viewRouter.showTabBar = false
            } //Link to seat selection view page
            .navigationDestination(isPresented: $showSeatSelectionView) {
                SeatSelectionView(viewRouter: viewRouter, film: film, selectedDate: selectedDate, selectedTime: selectedTime)
            }
        }
        
    }
    
    }

