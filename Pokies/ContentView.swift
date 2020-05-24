//
//  ContentView.swift
//  Pokies
//
//  Created by Mathena Angeles on 5/23/20.
//  Copyright © 2020 Mathena Angeles. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var icons = ["clover","dice","horseshoe","rabbit"]
    @State private var slots = Array(repeating: 0, count: 9)
    @State private var backgrounds = Array(repeating: Color.white, count: 9)
    @State private var credits = 1000
    private var bet = 5
    var body: some View {
        ZStack{
            // Background
            Rectangle().foregroundColor(Color(red:172/255,green:215/255,blue:230/255)).edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                // Title
                HStack{
                    Text("Feeling Lucky?").bold().foregroundColor(.black)
                    Image(systemName:"hare")
                }.padding(.bottom, 20.0).scaleEffect(2)
                // Credits
                Text("Credits: "+String(credits)).bold().foregroundColor(.black).padding(.all,10).background(Color.white.opacity(0.5)).cornerRadius(20)
                
                Spacer()
                // Slots
                VStack{
                    HStack{
                        Spacer()
                        SlotView(icon:$icons[slots[0]], background:$backgrounds[0])
                        SlotView(icon:$icons[slots[1]],background:$backgrounds[1])
                        SlotView(icon:$icons[slots[2]],background:$backgrounds[2])
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        SlotView(icon:$icons[slots[3]], background:$backgrounds[3])
                        SlotView(icon:$icons[slots[4]],background:$backgrounds[4])
                        SlotView(icon:$icons[slots[5]],background:$backgrounds[5])
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        SlotView(icon:$icons[slots[6]], background:$backgrounds[6])
                        SlotView(icon:$icons[slots[7]],background:$backgrounds[7])
                        SlotView(icon:$icons[slots[8]],background:$backgrounds[8])
                        Spacer()
                    }
                    
                }
//                .padding(.vertical, 20.0).background(Color(red: 177/255, green: 179/255, blue: 184/255))
                
                Spacer()
                HStack (spacing:20) {
                    VStack{
                        // Single Spin
                       Button(action: {
                          self.eval()
                       }) {
                           Text("Single Spin").bold().foregroundColor(.white).padding(.all,10).padding([.leading,.trailing],30).background(Color.black).cornerRadius(20)
                       }
                       Text("\(bet) Credits").padding(.top,10)
                   }
                    VStack{
                       // Max Spin
                       Button(action: {
                          self.eval(true)
                       }) {
                           Text("Wild Play").bold().foregroundColor(.white).padding(.all,10).padding([.leading,.trailing],30).background(Color.black).cornerRadius(20)
                       }
                       Text("\(bet*5) Credits").padding(.top,10)
                    }
                }
               
               
                Spacer()
            }
        }
    }
    func eval(_ isMax:Bool = false){
        self.backgrounds = self.backgrounds.map{ _ in Color.white}
        // Spin
        if isMax {
            self.slots = self.slots.map{ _ in Int.random(in:0...self.icons.count - 1)}
            
        } else {
            self.slots[3] = Int.random(in:0...self.icons.count - 1)
            self.slots[4] = Int.random(in:0...self.icons.count - 1)
            self.slots[5] = Int.random(in:0...self.icons.count - 1)
        }
        //Check
        check(isMax)
        
    }
    func check(_ isMax:Bool = false){
        var matches = 0
        if !isMax {
            if isMatch(3,4,5) {
                matches+=1
            }
        } else {
            // Top
            if isMatch(0,1,2){
                matches+=1
            }
            // Middle
            if isMatch(3,4,5) {
                matches+=1
            }
            // Bottom
            if isMatch(6,7,8) {
                matches+=1
            }
            // Diagonals
            if isMatch(0,4,8) {
                matches+=1
            }
            if isMatch(2,4,6) {
                matches+=1
            }
        }
        if matches > 0 {
            // One or More Matches
            self.credits += matches*bet*2
            
        } else if !isMax{
            // No Matches, Single Spin
            self.credits -= bet
            
        } else {
            // No Matches, Max Spin
            self.credits -= bet*5
            
        }
    }
    func isMatch(_ one:Int, _ two:Int, _ three:Int) -> Bool {
        if self.slots[one]==self.slots[two] && self.slots[two]==self.slots[three]{
            self.backgrounds[one]=Color(red: 152/255, green: 206/255, blue: 0/255)
            self.backgrounds[two]=Color(red: 152/255, green: 206/255, blue: 0/255)
            self.backgrounds[three]=Color(red: 152/255, green: 206/255, blue: 0/255)
            return true
        }
        return false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
