//
//  TapeCardView.swift
//  mixtape
//
//  Created by Olin Johnson on 2/19/24.
//

import SwiftUI

struct TapeCardView: View {
    let tape: Tape
    var body: some View {
        VStack {
            HStack {
                Text(tape.title)
                    .font(.largeTitle.bold())
                    .shadow(color: .black.opacity(0.4), radius: 10, x:1, y:1)
                    //.shadow(color:.black, radius:1)
                    .padding(.leading, 28)
                    .padding(.top, 20)
                Spacer()
            }.foregroundColor(.white)
            Spacer()
        }
        .background(
            tape.background
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                //.saturation(0.5)
        )
        .cornerRadius(20)
        .frame(height: 250)
        .padding([.leading, .trailing])
        .shadow(color: .black.opacity(0.3), radius:10, x:3, y:3)
    }
    
}

struct TapeCardView_Previews: PreviewProvider {
    
    static var tape = Tape.sample_tapes[0]

    static var previews: some View {
        TapeCardView(tape: tape)
            //.previewLayout(.fixed(width: 400, height: 250))
    }
}

