//
//  SettingsView.swift
//  PurePKG
//
//  Created by Lrdsnow on 1/10/24.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appData: AppData
    var body: some View {
            List {
                Section {
                    VStack(alignment: .leading) {
                        HStack(alignment: .center) {
                            Image("DisplayAppIcon").resizable().scaledToFit().frame(width: 90, height: 90).cornerRadius(20).padding(.trailing, 5).shadow(color: Color.black.opacity(0.5), radius: 3, x: 1, y: 2)
                            Text("PurePKG").font(.system(size: 40, weight: .bold, design: .rounded))
                        }
                    }.padding(.leading, 5)
                }.listRowBackground(Color.clear).listRowInsets(EdgeInsets())
                Section() {
                    HStack {
                        Text("App version")
                        Spacer()
                        Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0")
                    }.listRowBG()
                    HStack {
                        Text("Device")
                        Spacer()
                        Text(appData.deviceInfo.modelIdentifier)
                    }.listRowBG()
                    HStack {
                        Text("iOS version")
                        Spacer()
                        Text("\(appData.deviceInfo.major).\(appData.deviceInfo.sub)\(appData.deviceInfo.minor == 0 ? "" : ".\(appData.deviceInfo.minor)")\(appData.deviceInfo.build_number == "0" ? "" : " (\(appData.deviceInfo.build_number))")")
                    }.listRowBG()
                    HStack {
                        Text("Jailbreak type")
                        Spacer()
                        Text(appData.jbdata.jbtype == .rootful ? "Rootful" : appData.jbdata.jbtype == .rootless ? "Rootless" : appData.jbdata.jbtype == .roothide ? "Roothide" : "None")
                    }.listRowBG()
                    HStack {
                        Text("Installed tweak count")
                        Spacer()
                        Text("0")
                    }.listRowBG()
                    NavigationLink(destination: Text("Credits")) {
                        Text("Credits")
                    }.listRowBG()
                }
                Section() {
                    ColorPicker("Accent color", selection: .constant(.accent)).listRowBG()
                    Toggle(isOn: .constant(false), label: {Text("Use fluid gradient background")}).listRowBG().tint(.accent)
                    NavigationLink(destination: Text("Icons")) {
                        Text("Change Icon")
                    }.listRowBG()
                }
            }.listStyle(.insetGrouped).clearListBG().BGImage()
    }
}
