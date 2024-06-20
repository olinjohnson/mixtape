//
//  Tape.swift
//  mixtape
//
//  Created by Olin Johnson on 2/19/24.
//

import Foundation
import SwiftUI

struct Tape {
    var title: String
    var date: String
    var background: Image
    var artwork: [Image]?
    var text_title: String
    var body_text: String
    var songs: [Song]
    var id: UUID
}

extension Tape {
    static let sample_tapes: [Tape] =
    [
        Tape(title: "2023", date: "December 31st 2023", background: Image("zach_bryan"), text_title: "On the fence", body_text: "2023 was a year for the ages. There were highs, there were lows, but we made it through. Lots of good and bad memories. (more thorough reflection) Here are some songs to remember the new year by:", songs: [
            Song(cover: Image("noah_kahan"), artist: "Noah Kahan", name: "The View Between Villages"),
            Song(cover: Image("ed_sheeran"), artist: "Dermot Kennedy", name: "Lucky"),
            Song(cover: Image("hozier"), artist: "Gracie Abrams", name: "I Know It Won't Work"),
            Song(cover: Image("chance_pena"), artist: "Rascall Flatts", name: "Life is a Highway"),
            Song(cover: Image("dylan_gossett"), artist: "Kenny Loggins", name: "Danger Zone"),
            Song(cover: Image("ed_sheeran"), artist: "Luke Combs", name: "You Found Yours"),
            Song(cover: Image("noah_kahan"), artist: "Dylan Gossett", name: "Coal"),
            Song(cover: Image("hozier"), artist: "Kelly Clarkson", name: "Behind These Hazel Eyes"),
            Song(cover: Image("zach_bryan"), artist: "Taylor Swift", name: "We Are Never Ever Getting Back Together"),
        ], id:UUID()),
        Tape(title: "i am typing out 100 characters i am typing out 100 charactersi am typing out 100 characters i am typ", date: "December 31st 2023", background: Image("hozier"), text_title: "On the fence", body_text: "2023 was a year for the ages. There were highs, there were lows, but we made it through. Lots of good and bad memories. (more thorough reflection) Here are some songs to remember the new year by:", songs: [
            Song(cover: Image("noah_kahan"), artist: "Noah Kahan", name: "The View Between Villages"),
            Song(cover: Image("ed_sheeran"), artist: "Dermot Kennedy", name: "Lucky"),
            Song(cover: Image("hozier"), artist: "Gracie Abrams", name: "I Know It Won't Work"),
            Song(cover: Image("chance_pena"), artist: "Rascall Flatts", name: "Life is a Highway"),
            Song(cover: Image("dylan_gossett"), artist: "Kenny Loggins", name: "Danger Zone"),
            Song(cover: Image("ed_sheeran"), artist: "Luke Combs", name: "You Found Yours"),
            Song(cover: Image("noah_kahan"), artist: "Dylan Gossett", name: "Coal"),
            Song(cover: Image("hozier"), artist: "Kelly Clarkson", name: "Behind These Hazel Eyes"),
            Song(cover: Image("zach_bryan"), artist: "Taylor Swift", name: "We Are Never Ever Getting Back Together"),
            
        ], id:UUID()),
        Tape(title: "Road Trip", date: "July 16th 2022", background: Image("noah_kahan"), text_title: "On the fence", body_text: "Songs from our trek out west", songs: [
            Song(cover: Image("chance_pena"), artist: "Rascall Flatts", name: "Life is a Highway"),
            Song(cover: Image("dylan_gossett"), artist: "Kenny Loggins", name: "Danger Zone"),
            Song(cover: Image("ed_sheeran"), artist: "Luke Combs", name: "You Found Yours")
        ], id:UUID()),
        Tape(title: "Quitting my Job", date: "October 3rd 2020", background: Image("dan+shay"), text_title: "On the fence", body_text: "Songs from our trek out west", songs: [
            Song(cover: Image("noah_kahan"), artist: "Dylan Gossett", name: "Coal"),
            Song(cover: Image("hozier"), artist: "Kelly Clarkson", name: "Behind These Hazel Eyes"),
            Song(cover: Image("zach_bryan"), artist: "Taylor Swift", name: "We Are Never Ever Getting Back Together")
        ], id:UUID()),
        Tape(title: "i am typing out 100 characters i am typing out 100 charactersi am typing out 100 characters i am typ", date: "December 31st 2023", background: Image("hozier"), text_title: "On the fence", body_text: "2023 was a year for the ages. There were highs, there were lows, but we made it through. Lots of good and bad memories. (more thorough reflection) Here are some songs to remember the new year by:", songs: [
            Song(cover: Image("noah_kahan"), artist: "Noah Kahan", name: "The View Between Villages"),
            Song(cover: Image("ed_sheeran"), artist: "Dermot Kennedy", name: "Lucky"),
            Song(cover: Image("hozier"), artist: "Gracie Abrams", name: "I Know It Won't Work"),
            Song(cover: Image("chance_pena"), artist: "Rascall Flatts", name: "Life is a Highway"),
            Song(cover: Image("dylan_gossett"), artist: "Kenny Loggins", name: "Danger Zone"),
            Song(cover: Image("ed_sheeran"), artist: "Luke Combs", name: "You Found Yours"),
            Song(cover: Image("noah_kahan"), artist: "Dylan Gossett", name: "Coal"),
            Song(cover: Image("hozier"), artist: "Kelly Clarkson", name: "Behind These Hazel Eyes"),
            Song(cover: Image("zach_bryan"), artist: "Taylor Swift", name: "We Are Never Ever Getting Back Together"),
            
        ], id:UUID()),
    ]
}
