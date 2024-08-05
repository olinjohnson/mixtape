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
        VStack(alignment:.leading) {
            HStack {
                VStack(alignment:.leading) {
                    Text(tape.date, style:.date)
                        .font(.caption)//.bold())
//                        .shadow(color: .black.opacity(0.3), radius: 3, x:0, y:0)
                    Text(tape.title)
                        .font(.largeTitle.bold())
//                        .shadow(color: .black.opacity(0.3), radius: 3, x:0, y:0)
                        .multilineTextAlignment(.leading)
                    //.shadow(color:.black, radius:1)
                    Spacer()
                }
                .foregroundStyle(.white)
                Spacer()
            }
            .padding([.leading, .trailing], 28)
            .padding(.top, 20)
        }
        .frame(maxWidth:.infinity, minHeight: 250, maxHeight: 250)
        .background(
            Image(uiImage: UIImage(data: tape.cover)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .overlay {
                    VStack {}
                        .frame(maxWidth:.infinity, minHeight: 250, maxHeight: 250)
                        .background(.black.opacity(0.3))
                }
                //.saturation(0.5)
        )
        .cornerRadius(20)
        .padding([.leading, .trailing])
        //.shadow(color: .black.opacity(0.3), radius:10, x:3, y:3)
    }
    
}

//struct TapeCardView_Previews: PreviewProvider {
//    
//    static var tape = Tape.sample_tapes[0]
//
//    static var previews: some View {
//        TapeCardView(tape: tape)
//            //.previewLayout(.fixed(width: 400, height: 250))
//    }
//}

