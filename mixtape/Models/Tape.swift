//
//  Tape.swift
//  mixtape
//
//  Created by Olin Johnson on 2/19/24.
//

import Foundation
import SwiftUI

struct Tape {
    var id: UUID
    var cover: Image
    var date: Date
    var title: String
    var heading: String
    var body: String
    var songs: [Song]
    
    init(id: UUID, cover: Image, date: Date, title: String, heading: String, body: String, songs: [Song]) {
        self.id = id
        self.cover = cover
        self.date = date
        self.title = title
        self.heading = heading
        self.body = body
        self.songs = songs
    }
}

extension Tape {
    static let sample_tapes: [Tape] =
    [
        Tape(id:UUID(), cover: Image("zach_bryan"), date: Date(), title: "2023", heading: "On the fence", body: "2023 was a year for the ages. There were highs, there were lows, but we made it through. Lots of good and bad memories. (more thorough reflection) Here are some songs to remember the new year by:", songs: [
            Song(cover: Image("noah_kahan"), artist: "Noah Kahan", name: "The View Between Villages"),
            Song(cover: Image("ed_sheeran"), artist: "Dermot Kennedy", name: "Lucky"),
            Song(cover: Image("hozier"), artist: "Gracie Abrams", name: "I Know It Won't Work"),
            Song(cover: Image("chance_pena"), artist: "Rascall Flatts", name: "Life is a Highway"),
            Song(cover: Image("dylan_gossett"), artist: "Kenny Loggins", name: "Danger Zone"),
            Song(cover: Image("ed_sheeran"), artist: "Luke Combs", name: "You Found Yours"),
            Song(cover: Image("noah_kahan"), artist: "Dylan Gossett", name: "Coal"),
            Song(cover: Image("hozier"), artist: "Kelly Clarkson", name: "Behind These Hazel Eyes"),
            Song(cover: Image("zach_bryan"), artist: "Taylor Swift", name: "We Are Never Ever Getting Back Together"),
        ]),
        Tape(id:UUID(), cover: Image("hozier"), date: Date(), title: "i am typing out 100 characters i am typing out 100 charactersi am typing out 100 characters i am typ", heading: "On the fence", body: "2023 was a year for the ages. There were highs, there were lows, but we made it through. Lots of good and bad memories. (more thorough reflection) Here are some songs to remember the new year by:", songs: [
            Song(cover: Image("noah_kahan"), artist: "Noah Kahan", name: "The View Between Villages"),
            Song(cover: Image("ed_sheeran"), artist: "Dermot Kennedy", name: "Lucky"),
            Song(cover: Image("hozier"), artist: "Gracie Abrams", name: "I Know It Won't Work"),
            Song(cover: Image("chance_pena"), artist: "Rascall Flatts", name: "Life is a Highway"),
            Song(cover: Image("dylan_gossett"), artist: "Kenny Loggins", name: "Danger Zone"),
            Song(cover: Image("ed_sheeran"), artist: "Luke Combs", name: "You Found Yours"),
            Song(cover: Image("noah_kahan"), artist: "Dylan Gossett", name: "Coal"),
            Song(cover: Image("hozier"), artist: "Kelly Clarkson", name: "Behind These Hazel Eyes"),
            Song(cover: Image("zach_bryan"), artist: "Taylor Swift", name: "We Are Never Ever Getting Back Together"),
            
        ]),
        Tape(id:UUID(), cover: Image("noah_kahan"), date: Date(), title: "Road Trip", heading: "On the fence", body: "Songs from our trek out west", songs: [
            Song(cover: Image("chance_pena"), artist: "Rascall Flatts", name: "Life is a Highway"),
            Song(cover: Image("dylan_gossett"), artist: "Kenny Loggins", name: "Danger Zone"),
            Song(cover: Image("ed_sheeran"), artist: "Luke Combs", name: "You Found Yours")
        ]),
        Tape(id:UUID(), cover: Image("dan+shay"), date: Date(), title: "Quitting my Job", heading: "On the fence", body: "Songs from our trek out west", songs: [
            Song(cover: Image("noah_kahan"), artist: "Dylan Gossett", name: "Coal"),
            Song(cover: Image("hozier"), artist: "Kelly Clarkson", name: "Behind These Hazel Eyes"),
            Song(cover: Image("zach_bryan"), artist: "Taylor Swift", name: "We Are Never Ever Getting Back Together")
        ]),
    ]
}
