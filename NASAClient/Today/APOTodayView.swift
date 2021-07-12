import SwiftUI

struct APOTodayView: View {
    let picture: APODImage
    
    var body: some View {
        List {
            // TODO: Loading image
            Section(header: Text("")) {
                if let url = URL(string: picture.url) {
                    Link("Image URL", destination: url)
                }
            }
            
            Section(header: Text("Title")) {
                Text(picture.title)
                    .font(.body.bold())
            }
            
            Section(header: Text("Explanation")) {
                Text(picture.explanation)
            }
            
            Section(header: copyright) {
                EmptyView()
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Today")
    }
    
    private var copyright: some View {
        Text("copyright: \(picture.copyright)")
    }
}

struct APOTodayView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            APOTodayView(
                picture: .init(
                    copyright: "Bray FallsKeith Quattrocchi",
                    date: "2021-07-12",
                    explanation: "What will become of our Sun? The first hint of our Sun's future was discovered inadvertently in 1764. At that time, Charles Messier was compiling a list of diffuse objects not to be confused with comets. The 27th object on Messier's list, now known as M27 or the Dumbbell Nebula, is a planetary nebula, one of the brightest planetary nebulae on the sky -- and visible toward the constellation of the Fox (Vulpecula) with binoculars. It takes light about 1000 years to reach us from M27, featured here in colors emitted by hydrogen and oxygen. We now know that in about 6 billion years, our Sun will shed its outer gases into a planetary nebula like M27, while its remaining center will become an X-ray hot white dwarf star.  Understanding the physics and significance of M27 was well beyond 18th century science, though. Even today, many things remain mysterious about planetary nebulas, including how their intricate shapes are created.",
                    hdURL: "https://apod.nasa.gov/apod/image/2107/M27_Falls_3557.jpg",
                    mediaType: "image",
                    title: "M27: The Dumbbell Nebula",
                    url: "https://apod.nasa.gov/apod/image/2107/M27_Falls_960.jpg"
                )
            )
        }
    }
}
