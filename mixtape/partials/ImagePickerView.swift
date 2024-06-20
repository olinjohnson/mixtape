//
//  ImagePickerView.swift
//  mixtape
//
//  Created by Olin Johnson on 6/20/24.
//

import SwiftUI
import PhotosUI

struct ImagePickerView: View {
    
    let gr: GeometryProxy
    
    @State var selectedPhoto: PhotosPickerItem?
    @State private var image: Image?
    
    var body: some View {
        ZStack(alignment:.top){
            image?
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: gr.size.width, height: gr.size.height + max(0, gr.frame(in: .global).origin.y))
                .offset(y: -gr.frame(in: .global).origin.y)
            PhotosPicker(selection:$selectedPhoto, matching:.images) {
                Image(systemName: "camera")
//                    .resizable()
                    .background(.white)
//                    .frame(width:32)
            }
        }
        .task(id: selectedPhoto) {
            image = try? await selectedPhoto?.loadTransferable(type: Image.self) ?? Image("ed_sheeran")
        }
    }
}

#Preview {
    GeometryReader { gr in
        ImagePickerView(gr:gr)
    }
    .frame(height:150)
}
