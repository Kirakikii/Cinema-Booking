//
//  BookingsView.swift
//  cinema_booking
//
//  Created by 吴泓昕 on 5/8/24.
//

import SwiftUI

struct Ticket: Identifiable {
    let id: Int
    let filmName: String
    let cinema: String
    let date: String
    let time: String
    let seat: String
    let image: String
}

struct TicketsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var globalViewModel: GlobalViewModel
    @AppStorage("movieDetail") var movieDetailData: String = ""

    @State private var tickets = [
        Ticket(id: 1, filmName: "Film 1", cinema: "cinemaA", date: "2024-05-12", time: "19:00", seat: "A1", image: "poster1"),
        Ticket(id: 2, filmName: "Film 2", cinema: "cinemaA", date: "2024-05-12", time: "20:00", seat: "A2", image: "poster2")
    ]

    var body: some View {
        NavigationView { // 确保 TicketsView 在 NavigationView 内
            VStack(spacing: 0) {
                //ticketsNavBarView
                List {
                    ForEach(tickets) { ticket in
                        HStack {
                            Image(systemName: ticket.image)
                                .resizable()
                                .frame(width: 60, height: 60)
                                .cornerRadius(10)
                                .padding()
                            
                            VStack(alignment: .leading) {
                                Text(ticket.filmName)
                                Text(ticket.cinema)
                                Text(ticket.date)
                                Text(ticket.time)
                                Text(ticket.seat)
                            }
                            Spacer()
                        }
                        .padding(.vertical)
                    }
                    .onDelete(perform: deleteTicket)
                }
            }
            
            .navigationTitle(Text("Ticket"))
            .onDisappear(perform: {
                globalViewModel.showDetails = false
            })
        }
    }
    
    func deleteTicket(at offsets: IndexSet) {
        tickets.remove(atOffsets: offsets)
    }

    var ticketsNavBarView: some View {
        VStack {
            HStack {
                //backButton
                    //.offset(y: 20)
                    //.offset(x: 12)
                Spacer()
                Text("Tickets")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                Spacer()
                //backButton.opacity(0) // 保持标题居中
            }
            .padding(.vertical, 25)
            .background(Color.indigo)
        }
        .navigationBarTitle("Tickets", displayMode: .inline)
    }

    var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.white)
                .imageScale(.large)
        }
    }
}

struct TicketsView_Previews: PreviewProvider {
    static var previews: some View {
        TicketsView()
    }
}
