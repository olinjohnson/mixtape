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
    @State var image: Image?
    
    var body: some View {
        ZStack(alignment:.center){
            image?
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: gr.size.width, height: gr.size.height + max(0, gr.frame(in: .global).origin.y))
                .offset(y: -gr.frame(in: .global).origin.y)
            PhotosPicker(selection:$selectedPhoto, matching:.images) {
                VStack(alignment: .center) {
                    Image(systemName: "camera.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .padding(18)
                        .foregroundColor(.black)
                }
                .background(.white.opacity(0.5))
                .frame(width:60, height:60)
                .cornerRadius(100)
            }
            .offset(y: -gr.frame(in: .global).origin.y)
        }
        .task(id: selectedPhoto) {
            image = try? await selectedPhoto?.loadTransferable(type: Image.self) ?? Image("no_select")
        }
    }
}

#Preview {
    GeometryReader { gr in
        ImagePickerView(gr:gr)
    }
    .frame(height:150)
}
