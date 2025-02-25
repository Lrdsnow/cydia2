//
//  Cydia2.swift
//  Cydia2
//
//  Created by Lrdsnow on 2/24/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @EnvironmentObject var appData: AppData
    @Binding var tab: Int
    @Binding var importedPackage: Package?
    @Binding var showPackage: Bool
    let preview: Bool
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Cydia", systemImage: "star")
                }
                .tag(0)
            
            BrowseView(importedPackage: $importedPackage, showPackage: $showPackage, preview: preview)
                .tabItem {
                    Label("Sources", systemImage: "square.stack")
                }
                .tag(1)
            
            ChangesView()
                .tabItem {
                    Label("Changes", systemImage: "clock")
                }
                .tag(2)
            
            InstalledView(preview: preview)
                .tabItem {
                    Label("Installed", systemImage: "square.and.arrow.down")
                }
                .tag(3)
            
            SearchView(preview: preview)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(4)
            
            if !appData.queued.all.isEmpty || Device().osString == "tvOS" {
                QueueView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Queued")
                    }
                    .tag(3)
            }
        }.onAppear() { startup() }
    }
    
    private func startup() {
        if #available(iOS 14.0, tvOS 14.0, *) {
            if !preview {
                log("PurePKG Running on \(Device().modelIdentifier) running \(Device().osString) \(Device().osString == "macOS" ? Device().build_number : "\(Device().pretty_version) (\(Device().build_number))")")
                appData.installed_pkgs = RepoHandler.getInstalledTweaks(Jailbreak().path+"/Library/dpkg")
                appData.repos = RepoHandler.getCachedRepos()
                appData.pkgs = appData.repos.flatMap { $0.tweaks }
                if UserDefaults.standard.bool(forKey: "refreshOnStart") {
                    Task(priority: .background) {
                        refreshRepos(appData)
                    }
                }
            }
        }
    }
}

struct HomeView: View {
    var body: some View {
        NavigationViewC {
            List {
                Section {
                    HStack {
                        Image("logo")
                            .resizable()
                            .frame(width: 73, height: 73)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .padding(.leading, 40)
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Welcome to Cydia²")
                                .font(.title)
                            Text("by ")
                                .font(.headline)
                                .foregroundColor(.gray)
                            + Text("Lrdsnow")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }.padding(.leading, -5)
                        Spacer()
                    }.padding(0)
                }.listRowBackground(Color.clear).listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
                Section {
                    HStack {
                        HStack {
                            Image("facebookLogo")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            Text("Cydia²")
                            Spacer()
                            Image(systemName: "chevron.right").font(.system(size: UIFont.systemFontSize, weight: .medium)).opacity(0.35)
                        }
                        Divider()
                        HStack {
                            Image("xLogo")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            Text("Cydia²")
                            Spacer()
                            Image(systemName: "chevron.right").font(.system(size: UIFont.systemFontSize, weight: .medium)).opacity(0.35)
                        }
                    }
                }.listRowBackground(Color.clear)
                Section {
                    HStack {
                        HStack {
                            Image("Tweaks")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            Text("Featured")
                            Spacer()
                            Image(systemName: "chevron.right").font(.system(size: UIFont.systemFontSize, weight: .medium)).opacity(0.35)
                        }
                        Divider()
                        HStack {
                            Image("Themes")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            Text("Themes")
                            Spacer()
                            Image(systemName: "chevron.right").font(.system(size: UIFont.systemFontSize, weight: .medium)).opacity(0.35)
                        }
                    }
                }
                Section {
                    NavigationLink(destination: {
                        
                    }, label: {
                        HStack {
                            Image("Localization")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            Text("Manage Account")
                            Spacer()
                        }
                    })
                }.listRowBackground(Color.green.opacity(0.07))
                
                Section {
                    NavigationLink(destination: {
                        
                    }, label: {
                        HStack {
                            Text("Upgrading & Jailbreaking Help")
                            Spacer()
                        }
                    })
                    NavigationLink(destination: {
                        
                    }, label: {
                        HStack {
                            Text("Find Extensions for Applications")
                            Spacer()
                        }
                    })
                    NavigationLink(destination: {
                        
                    }, label: {
                        HStack {
                            Text("More Package Sources")
                            Spacer()
                        }
                    })
                }
                
                Section("USER GUIDES") {
                    NavigationLink(destination: {
                        
                    }, label: {
                        HStack {
                            Text("Frequently Asked Questions")
                            Spacer()
                        }
                    })
                    NavigationLink(destination: {
                        
                    }, label: {
                        HStack {
                            Text("Copying Files to/from Device")
                            Spacer()
                        }
                    })
                    NavigationLink(destination: {
                        
                    }, label: {
                        HStack {
                            Text("OpenSSH Access How-To")
                            Spacer()
                        }
                    })
                    NavigationLink(destination: {
                        
                    }, label: {
                        HStack {
                            Text("Root Password How-To")
                            Spacer()
                        }
                    })
                    NavigationLink(destination: {
                        
                    }, label: {
                        HStack {
                            Text("Storage Information")
                            Spacer()
                        }
                    })
                }
                
                Section("DEVELOPERS ONLY") {
                    NavigationLink(destination: {
                        
                    }, label: {
                        HStack {
                            Text("Useful Developer Resources")
                            Spacer()
                        }
                    })
                }
                
                Section {
                    NavigationLink(destination: {
                        
                    }, label: {
                        HStack {
                            Text("Credits / Thank You")
                            Spacer()
                        }
                    })
                }
            }
            .listStyle(.grouped)
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("About") {
                        // About action
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Reload") {
                        // Reload action
                    }
                }
            }
        }
    }
}

struct ChangesView: View {
    var body: some View {
        NavigationView {
            Text("No Changes")
                .navigationTitle("Changes")
        }
    }
}

