#!/usr/bin/env ruby

# Exit early if no sessions with my username are found
exit unless `who -q`.include? ENV['USER']

require 'dotenv'
require 'twilio-ruby'

Dotenv.load

TWILIO_ACCOUNT_SID = ENV['TWILIO_ACCOUNT_SID']
TWILIO_AUTH_TOKEN  = ENV['TWILIO_AUTH_TOKEN']

@twilio = Twilio::REST::Client.new TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN

# Phone numbers
my_number  = ENV['MEU_CEL']
her_number = ENV['CEL_AMOR']

reason = [
  'Bicho pegando aqui...',
  'Tenho que terminar um negócio aqui...',
  'Alguém fez merda no sistema aqui de novo...',
  'Bruno tá no meu pé pra entregar um trem aqui...'
].sample

# Send a text message
@twilio.messages.create(
  from: my_number, to: her_number, body: "Garrado no trampo. #{reason}"
)

# Log this
puts "Message sent at: #{Time.now} | Reason: #{reason}"
