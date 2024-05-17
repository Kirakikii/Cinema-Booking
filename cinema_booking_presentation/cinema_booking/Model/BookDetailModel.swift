import Foundation
import SwiftData

@Model
class BookingDetailModel{
    var filmName: String
    var cinema: String
    var date: Date
    var time: String
    var seat: String
    
    init(
        filmName: String,
        cinema: String,
        date: Date,
        time: String,
        seat: String
    
    ){
        self.filmName = filmName
        self.cinema = cinema
        self.date = date
        self.time = time
        self.seat = seat
    }
}
