//
//  TracksView.swift
//  mixtape
//
//  Created by Olin Johnson on 7/26/24.
//

import SwiftUI
import Combine

struct TracksView: View {
    
    @Binding var tracks: [Song]?
    var event: AnyPublisher<ExpandCollapseState, Never>
    
    var body: some View {
        VStack(alignment:.leading, spacing:5) {
            if ((tracks ?? []).count) > 0 {
                ForEach(tracks!.sorted(by: {$0.order < $1.order})) { track in
                    _FoldableCaptionView(track: track, event: event)
                    if (track.order < Double(tracks!.count) - 1) {
                        Divider()
                            .padding(.leading, 60)
                    }
                }
            } else {
                VStack(alignment:.leading) {
                    Text("No tracks yet")
                        .bold()
                }
                //.padding([.top, .bottom], 5)
            }
        }
        //.padding([.leading, .trailing])
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .background(Color(uiColor: UIColor.systemGray6))
        .cornerRadius(10)
    }
}

struct _FoldableCaptionView: View {
    
    var track: Song
    @State var showingCaption = false
    var event: AnyPublisher<ExpandCollapseState, Never>
    
    var body: some View {
        HStack {
            SongView(track: track)
            Button(action: {
                withAnimation {
                    self.showingCaption.toggle()
                }
            }) {
                if self.showingCaption {
                    Image(systemName: "chevron.down")
                        .foregroundStyle(Color(uiColor: UIColor.systemGray3))
                        .padding(.trailing, 5)
                } else {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Color(uiColor: UIColor.systemGray3))
                        .padding(.trailing, 5)
                }
            }
        }
        .onAppear(perform: {
            self.showingCaption = track.caption.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 ? true : false
        })
        .onReceive(event, perform: { e in
            withAnimation {
                if e.state {
                    self.showingCaption = track.caption.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 ? true : false
                } else {
                    self.showingCaption = false
                }
            }
        })
        
        if self.showingCaption {
            if track.caption.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
                Text("This track hasn't been captioned yet.")
                    .padding(.leading, 65)
                    .padding(.bottom, 8)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(Color(uiColor: UIColor.systemGray))
            } else {
                Text(track.caption)
                    .padding(.leading, 65)
                    .padding(.bottom, 8)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

//#Preview {
//    TracksView(tracks: Tape.sample_tapes[0].songs)
//}
