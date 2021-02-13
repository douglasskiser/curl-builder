//
//  ContentView.swift
//  curl-builder
//
//  Created by Douglass Kiser on 11/26/20.
//

import SwiftUI

struct ContentView: View {
    @State var url: String = ""
    @State var curlBody: String = ""
    @State var selectedMethod = Methods.GET
    @State var curlOutput: String = ""
    @State var headers: [Header] = []
    @State var isJSONContentType = false
    @State var isAcceptSelfSignedCerts = false
    @State var isVerbose = false
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text("CURL Builder")
                    .font(.title)
            }
            VStack(alignment: .leading) {
                Picker(selection: $selectedMethod, label: Text("Method"), content: {
                    Text("GET").tag(Methods.GET)
                    Text("POST").tag(Methods.POST)
                })
                TextField("URL", text: $url)
                if #available(OSX 11.0, *) {
                    VStack(alignment: .leading) {
                        
                        Label("Body", systemImage: /*@START_MENU_TOKEN@*/"42.circle"/*@END_MENU_TOKEN@*/)
                            .labelStyle(TitleOnlyLabelStyle())
                        TextEditor(text: $curlBody)
                    }
                } else {
                    TextField("Body", text: $curlBody)
                }
                
                Button("Add Custom Header", action: {
                    self.headers.append(Header(key: "", value: ""))
                })
                
                ForEach(0..<headers.count, id: \.self) { index in
                    HStack {
                        TextField("Key", text: Binding(get: { self.headers[index].key }, set: { self.headers[index].key = $0}))
                        TextField("Value", text: Binding(get: { self.headers[index].value }, set: { self.headers[index].value = $0}))
                        Button("Remove", action: {
                            self.headers.remove(at: index)
                        })
                    }
                }
                
                Toggle("JSON Content Type", isOn: $isJSONContentType)
                Toggle("Accept Self-Signed Certs", isOn: $isAcceptSelfSignedCerts)
                Toggle("Verbose", isOn: $isVerbose)
                Spacer()
                Button("Generate Command", action: {
                    self.curlOutput = "curl "
                    if (self.isVerbose == true) {
                        self.curlOutput += "-v "
                    }
                    if (self.isAcceptSelfSignedCerts == true) {
                        self.curlOutput += "--insecure "
                    }
                    self.curlOutput += "-X" + self.selectedMethod.rawValue + " "
                    for header in self.headers {
                        self.curlOutput += "-H '\(header.key): \(header.value)' "
                    }
                    if (self.isJSONContentType == true) {
                        self.curlOutput += "-H \"Content-type: application/json\" "
                    }
                    if (self.curlBody.count > 0) {
                        self.curlOutput += "-d '" + self.curlBody + "' "
                    }
                    if (self.url.count > 0) {
                        self.curlOutput += "'" + self.url + "' "
                    }
                })
            }
            Spacer()
            HStack {
                TextField("Output", text: $curlOutput)
            }
        }.padding(.all)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
