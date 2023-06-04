import SwiftUI

public struct SettingsView: View {
    public var body: some View {
        List {
            NavigationLink {
                APIKeyView()
            } label: {
                HStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.yellow)
                        .overlay {
                            Image(systemName: "key.fill")
                                .foregroundColor(.white)
                        }
                        .padding(.trailing, 8)
                    
                    Text("API Key")
                }
            }
            
            NavigationLink {
                LanguageView()
            } label: {
                HStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.green)
                        .overlay {
                            Image(systemName: "globe")
                                .foregroundColor(.white)
                        }
                        .padding(.trailing, 8)
                    
                    Text("Language")
                }
            }
        }
        .navigationTitle("Settings")
    }
    
    public init() {}
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}
