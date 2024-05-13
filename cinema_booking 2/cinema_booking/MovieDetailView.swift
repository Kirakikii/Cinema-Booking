import SwiftUI
 
struct MoviedetailView: View {
    @State private var selectedDateIndex = 0
    @State private var selectedTimeIndex = -1
    @State private var showFullDescription = false
    
    let timeOptions = [
        "10:00", "12:35", "14:00", "15:55", "18:15", "21:30", "23:05"
    ]
 
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
             if hour > currentHour || (hour == currentHour && minute >= currentMinute) {
                 return true
             } else {
                 return false
             }
         }
     }
    
    var body: some View {
        VStack {
            Image("poster1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400, height: 250)
            
            ScrollView {
                VStack(spacing: 5) {
                    Text("Dune 2")
                        .font(.title)
                        .fontWeight(.heavy)
                    Spacer()
                    Text("Rate: 8.5/10")
                        .font(.caption)
                    
                    Text("About film")
                        .font(.title3)
                        .fontWeight(.bold)
                    if showFullDescription {
                        Text("Dune: Part Two is a 2024 American epic science fiction film directed and produced by Denis Villeneuve, who co-wrote the screenplay with Jon Spaihts.")
                            .foregroundColor(.secondary)
                            .transition(.opacity)
                        Button("Read Less") {
                            withAnimation {
                                showFullDescription.toggle()
                            }
                        }
                        .foregroundColor(.blue)
                    } else {
                        Text("Dune: Part Two is a 2024 American epic science fiction film directed and produced by Denis Villeneuve, who co-wrote the screenplay with Jon Spaihts.")
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
                    
                    Text("Available Times") // Added Available Times header
                        .font(.headline)
                        .padding(.top)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(0..<availableTimeOptions.count, id: \.self) { index in
                            Button(action: {
                                selectedTimeIndex = index
                            }) {
                                Text(availableTimeOptions[index])
                                    .foregroundColor(selectedTimeIndex == index ? .black : .black.opacity(0.7)) // Changed selected time text color to black
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(selectedTimeIndex == index ? Color.blue.opacity(0.3) : Color.gray.opacity(0.3))
                                    .cornerRadius(10)
                            }
                        }
                    }
                    
                    Button("Next") {
                        // Action for next
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
struct MoviedetailView_Previews: PreviewProvider {
    static var previews: some View {
        MoviedetailView()
    }
}

