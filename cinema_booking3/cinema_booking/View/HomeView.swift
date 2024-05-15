//
//  HomeView.swift
//  cinema_booking
//
//  Created by 吴泓昕 on 5/8/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var globalViewModel: GlobalViewModel
    @State private var selectedCinema: String = "Choose Cinema"
    @State private var selectedDate = Date()
    @State private var  movie = Movie(name: "", poster: "")
    
    // Demo wireframe
    let movies = [
        Movie(name: "Dune 2", poster: "poster1"),
        Movie(name: "Movie 2", poster: "poster2"),
        Movie(name: "Movie 3", poster: "poster3"),
        Movie(name: "Movie 4", poster: "poster4")
    ]
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 0) {
                //CustomNavBarView
                
                CinemaPicker(
                    selectedCinema: $selectedCinema,
                    selectedDate: $selectedDate,
                    cinemas: ["Select the cinemas", "Events - Broadway", "Pacific Cinema - Central Park", "Events - Town Hall", "Ritz - Randwick", "Dendy Cinema - Newtown"])
                
                
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(movies, id: \.name) { movie in
                            movieCard(for: movie)
                        }
                    }
                   // .padding(.top, 20)
                }
            }
            //.edgesIgnoringSafeArea(.top)
            .navigationTitle(Text("Home"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $globalViewModel.showDetails) {
                MovieDetailView(movie: movie)
            }
            
        }
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
        .onTapGesture {
            self.movie = movie
            globalViewModel.showDetails = true
            
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
        HStack {
            // 左侧透明按钮，使用相同的大小来平衡布局
            Button(action: {}) {
                Image(systemName: "ticket")
                    .opacity(0) // 透明
                    .imageScale(.large) // 使用与右侧相同的图标大小
                    .padding(10) // 增加填充来扩大点击区域
            }
            
            Spacer()
            
            Text("Home")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 40)
            
            Spacer()
            
            // 票形图标按钮，点击后跳转到 TicketsView
            NavigationLink(destination: TicketsView()) {
                Image(systemName: "ticket")
                    .foregroundColor(.white)
                    .imageScale(.large) // 增大图标
                    .padding(10) // 增加填充来扩大点击区域
            }
            .background(Color.indigo) // 确保填充区域也有相同的背景色
            .clipShape(Circle()) // 使用圆形剪裁来美化点击区域
            .offset(y: 22)
        }
        .padding(.horizontal)
        .padding(.vertical, 25)
        .background(Color.indigo)
    }
}



