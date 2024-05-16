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
    @EnvironmentObject var userVM: UserViewModel
    
    @ObservedObject var viewRouter: ViewRouter
    @AppStorage("movieDetail") var movieDetailData: String = ""
    
    @State private var tickets = [Ticket()]
    // Demo wireframe
    
    
    
    var body: some View {
        VStack (spacing:0){
            TicketsNavBarView
            
            List{
                ForEach(tickets) {ticket in
                    HStack {
                        Image(ticket.image)
                            .resizable()
                            .frame(width:110, height:150)
                            .cornerRadius(5)
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
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.top)
        .task{
            tickets = await userVM .getAllTickets()
        }
    }
    
    func deleteTicket(at offsets: IndexSet){
        offsets.forEach({
            index in
           _ = userVM.removeTickets(ticket: tickets[index])
        })
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
        // Create an instance of ViewRouter for preview
        let viewRouter = ViewRouter()
        
        // Provide the ViewRouter instance to HomeView
        TicketsView(viewRouter: viewRouter)
            .environmentObject(viewRouter)  // if needed elsewhere in the view hierarchy
    }
}


