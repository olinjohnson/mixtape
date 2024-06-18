//
//  NavBackView.swift
//  mixtape
//
//  Created by Olin Johnson on 2/23/24.
//

import SwiftUI

struct NavBackView: View {
    let dismiss: DismissAction
    
    var body: some View {
        Button(action:{
            dismiss()
        },label: {
            Text(Image(systemName: "chevron.left"))
                .font(.system(size: 16))
                .bold()
                .padding(10)
                .foregroundColor(.white)
                .frame(minWidth:40, minHeight:40)
                .background(.gray.opacity(0.5))
                .cornerRadius(14)
                .padding(40)
        })
    }
}

/*#Preview {
    NavBackView(dismiss: nil)
}*/
