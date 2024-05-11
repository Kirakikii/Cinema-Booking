//
//  BookingsView.swift
//  cinema_booking
//
//  Created by 吴泓昕 on 5/8/24.
//

import SwiftUI

struct Ticket: Identifiable{
    let id: Int
    let filmName: String
    let cinema: String
    let date: String
    let time: String
    let seat: String
    let image: String
}


struct TicketsView: View {
    @State private var tickets = [
        Ticket(id:1, filmName: "Film 1", cinema: "cinemaA", date: "2024-05-12", time: "19:00", seat: "A1", image: "poster1"),
        Ticket(id:2, filmName: "Film 2", cinema: "cinemaA", date: "2024-05-12", time: "20:00", seat: "A2", image: "poster2")
    ]
    // Demo wireframe
    
    var body: some View {
        VStack (spacing:0){
            TicketsNavBarView
            
            List{
                ForEach(tickets) {ticket in
                    HStack {
                        Image(systemName: ticket.image)
                            .resizable()
                            .frame(width:60, height:60)
                            .cornerRadius(10)
                            .padding()
                        
                        VStack(alignment: .leading) {
                            Text("\(ticket.filmName)")
                            Text("\(ticket.cinema)")
                            Text("\(ticket.date)")
                            Text("\(ticket.time)")
                            Text("\(ticket.seat)")
                        }
                        Spacer()
                    }
                    .padding(.vertical)
                }
                .onDelete(perform: deleteTicket)
            }
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
    }
    func deleteTicket(at offsets: IndexSet){
        tickets.remove(atOffsets: offsets)
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
}

struct TicketsView_Previews: PreviewProvider {
    static var previews: some View {
        TicketsView()
    }
}
