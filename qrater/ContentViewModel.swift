//
//  ContentViewModel.swift
//  qrater
//
//  Created by FulFlllY on 8/23/24.
//

import Foundation
import OpenAI

class ContentViewModel {
    @Published var songName: String = "Martin Garrix feat. Bonn - High On Life (Official Video)"
    
    @Published var songComments: [String] = [ "My new track High On Life featuring Bonn is out now! Let me know what you think of it! ❤️",
                                              "🔥🔥🔥",
                                              "Listening to music, I remember old days when corona was only a drink",
                                              "I went to a Martin Garrix concert last week and when he played this song.... I can't even explain that experience.... Goosebumps🔥🔥🔥",
                                              "Anyone in 2024? 🤛🏼🫶🏻",
                                              "BONN: what kind of music you wanna make.",
                                              "MARTIN: music that makes people high without taking drugs (higher than drugs)",
                                              "Everyone is appreciating Martin Garrix but no one is talking about Bonn... His voice 😍😍",
                                              "I'm 54.  Just really found EDM.  Been watching videos, checking out BPM, Pandora, Soundcloud. The passion and power in this song is life-changing. Sitting here with tears streaming. Thank you.",
                                              "Happy Birthday High On life ❤, my heart is broken, but i love you"
                                          ]
    
    func testQuery() async -> String {
        let commentsContent = songComments.joined(separator: " ")

        let query = ChatQuery(messages: [.init(role: .user, content: "Classify the emotional impact of this song: \(songName). Based on the following comments: \(commentsContent). Use predefined keywords to determine the dominant emotional responses. Don't try to squeeze in redundant stuffs but just put keywords that are most clear and essential. (Maybe 3 to 4?) Keywords include: Joyful, Energizing, Feel-good, Uplifting, Euphoric, Melancholic, Sorrowful, Gloomy, Mournful, Tearful, Aggressive, Intense, Furious, Provocative, Explosive, Soothing, Tranquil, Serene, Relaxing, Meditative, Chilling, Menacing, Foreboding, Tense, Alarming, Romantic, Passionate, Tender, Heartfelt, Amorous, Sentimental, Nostalgic, Empowering, Inspiring, Captivating, Enchanting, Spellbinding, Hypnotic, Transfixing, Magnetic."
)!], model: .gpt4_o_mini)
                
        do {
            let result = try await openAI.chats(query: query)
            return result.choices.first?.message.content?.string ?? ""
        } catch {
            print(error)
            return "Fail to Get Result"
        }
    }
}
