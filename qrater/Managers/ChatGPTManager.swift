import Foundation
import SwiftOpenAI

final class ChatGPTManager {
    static let shared = ChatGPTManager()
    
    private init() {}

    func requestCurate(mood: String, vibe: String, action: String) async throws -> String {
        let assistant = try await service.retrieveAssistant(id: assistantID)
        print("assistant: \(assistant.name ?? ""), \(assistant.id)")
        
        let threadParamters = CreateThreadParameters()
        let thread = try await service.createThread(parameters: threadParamters)
        print("create thread: \(thread.id)")
        
        let prompt = "Based on the user's current mood, desired vibe, and activity, retrieve a list of song recommendations from the provided JSON file, which contains song names and their associated moods. Ensure that the song selections align with the user's stated mood, vibe, and activity. If specific song examples are provided by the user, prioritize songs that are similar to these examples while still meeting the other conditions. Here are the input details:- Mood: \(mood). Desired vibe or song examples: \(vibe). Current activity: \(action). The JSON file will be used to match these inputs with songs that share similar mood attributes and vibes as described by the user. Please answer json format that contain songName, artist, keyword like JSON file."
        let messageParamters = MessageParameter(role: .user, content: .stringContent(prompt))
        let message = try await service.createMessage(threadID: thread.id, parameters: messageParamters)
        print("create message: \(message.id) from \(message.threadID)")
        
        
        
        var resultText = ""
        let runParamters = RunParameter(assistantID: assistant.id)
        let stream = try await service.createRunStream(threadID: thread.id, parameters: runParamters)
        for try await result in stream {
            switch result {
            case .threadMessageDelta(let messageDelta):
                let content = messageDelta.delta.content.first
                switch content {
                case .imageFile, nil:
                    break
                case .text(let textContent):
                    print(textContent.text.value)
                    resultText += textContent.text.value
                }
            case .threadRunStepDelta(let runStepDelta):
                let toolCall = runStepDelta.delta.stepDetails.toolCalls?.first?.toolCall
                switch toolCall {
                case .codeInterpreterToolCall(let toolCall):
                    print(toolCall.input ?? "")
                case .fileSearchToolCall(let toolCall):
                    print("PROVIDER: File search tool call \(toolCall)")
                case .functionToolCall(let toolCall):
                    print(toolCall.arguments)
                case nil:
                    print("PROVIDER: tool call nil")
                }
            case .threadRunCompleted(let runObject):
                print("PROVIDER: the run is completed - \(runObject)")
            default:
                break
            }
        }
        return resultText
    }
    
    
    func description(songName : String, artist : String) async throws -> String {
        
        let prompt = "Please give a thorough script of the song \(songName) by \(artist). In like 300 words: about its style, its general mood, its influence in the music industry (if it is valid). Write in continuous style"
        let parameters = ChatCompletionParameters(messages: [.init(role: .user, content: .text(prompt))], model: .gpt4omini)
        let choices = try await service.startChat(parameters: parameters).choices
        let val = choices.compactMap(\.message.content)
        let joined = val.joined(separator: ", ")
        print(val)

        return joined
    }

}
