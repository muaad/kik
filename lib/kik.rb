require "kik/version"
require "httparty"
require "base64"

module Kik
	API_URL = "https://api.kik.com/v1"
	class Client
		def initialize(bot_name, api_key)
			@bot_name = bot_name
			@api_key = api_key
		end

		def post url, body
			auth = "#{@bot_name}:#{@api_key}"
			HTTParty.post(url, {
				body: body,
				headers: {
					'Content-Type' => 'application/json',
					'Authorization' => "Basic #{Base64.encode64(auth)}"
				},
				debug_output: $stdout
			})
		end

		def set_webhook url, features={}
			data = {
				webhook: url,
				features: features
			}
			post("#{API_URL}/config", data.to_json)
		end

		def messages
			Message.new(self)
		end
	end

	class Message
		def initialize(client)
			@client = client
		end

		def send_text user_name, chat_id, message, options=[], keyboard=false
			body = {
					messages: [
			            {
			                body: message,
			                to: user_name,
			                type: 'text',
			                chatId: chat_id
			            }
		        	]
	    	}
	    	body[:messages][0].merge!({keyboards: construct_keyboard(options, keyboard)}) if keyboard
	        @client.post("#{API_URL}/message", body.to_json)
		end

		def construct_keyboard options, hidden
			keyboard = []
			keyboard << {type: "suggested", hidden: !hidden, responses: []}
			options.each do |option|
				keyboard[0][:responses] << { type: "text", body: option }
			end
			keyboard
		end
	end
end
