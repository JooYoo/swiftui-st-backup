//
//  InputBox.swift
//  Todo
//
//  Created by Yu on 2022/2/14.
//

import SwiftUI

struct InputBox: View {
    @Binding var inputValue: String
     
     var body: some View{
         TextField("input todo...", text: $inputValue)
             .disableAutocorrection(true)
             .autocapitalization(.none)
     }
}

struct InputBox_Previews: PreviewProvider {
    static var previews: some View {
        InputBox(inputValue: .constant(""))
    }
}
