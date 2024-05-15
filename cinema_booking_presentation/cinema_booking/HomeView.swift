//
//  HomeView.swift
//  cinema_booking
//
//  Created by 吴泓昕 on 5/8/24.
//

import SwiftUI



struct HomeView: View {
    @ObservedObject var viewRouter: ViewRouter
    @State private var selectedCinema: String = "Choose Cinema"
    @State private var selectedDate = Date()
    
    
    // Demo wireframe
    let films: [Film] = Bundle.main.decode([Film].self, from: "FilmDetails.json")
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                CustomNavBarView
                
                CinemaPicker(
                    selectedCinema: $selectedCinema,
                    selectedDate: $selectedDate,
                    cinemas: ["Choose Cinema", "Events - Broadway", "Pacific Cinema - Central Park", "Events - Town Hall", "Ritz - Randwick", "Dendy Cinema - Newtown"])
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(films) { film in
                            movieCard(for: film)
                        }
                    }
                    .padding(.top, 20)
                }
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
    
    private func movieCard(for film: Film) -> some View {
        NavigationLink(destination: MovieDetailView(film: film,viewRouter: viewRouter)) {
            HStack {
                Image(film.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 150)
                    .cornerRadius(8)
                    .padding()
                
                Text(film.filmName)
                    .font(.headline)
                    .padding()
                
                Spacer()
            }
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .padding(.horizontal)
        }
        .simultaneousGesture(TapGesture().onEnded {
            viewRouter.showTabBar = false
        })
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
    
    
 
        
    }


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        // Create an instance of ViewRouter for preview
        let viewRouter = ViewRouter()
        
        // Provide the ViewRouter instance to HomeView
        HomeView(viewRouter: viewRouter)
            .environmentObject(viewRouter)  // if needed elsewhere in the view hierarchy
    }
}

