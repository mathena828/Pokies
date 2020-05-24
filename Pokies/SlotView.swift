//
//  SlotView.swift
//  Pokies
//
//  Created by Mathena Angeles on 5/23/20.
//  Copyright © 2020 Mathena Angeles. All rights reserved.
//

import SwiftUI

struct SlotView: View {
    @Binding var icon:String
    @Binding var background:Color
    var body: some View {
        Image(icon).resizable().aspectRatio(1,contentMode:.fit).background(background.opacity(0.5)).overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white, lineWidth: 5)
        ).cornerRadius(20)
    }
}

struct SlotView_Previews: PreviewProvider {
    static var previews: some View {
        SlotView(icon: Binding.constant("clover"), background: Binding.constant(Color(red: 152/255, green: 206/255, blue: 0/255)))
    }
}
