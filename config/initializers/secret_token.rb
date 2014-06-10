# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
# VolunteerApp::Application.config.secret_key_base = '9dfb3aa5dd0a5c06184f0c3cff0b0bf8a66f3d5f93f331f5a9429a1e10d767859fbd9f603be9651a9541e2f79afa933e4d78d23476d2847855f9f8bb26c26695'

require 'securerandom'

def secure_token
  token_file = Rails.root.join('.secret')
  if File.exist?(token_file)
    # Use the existing token.
    File.read(token_file).chomp
  else
    # Generate a new token and store it in token_file.
    token = SecureRandom.hex(64)
    File.write(token_file, token)
    token
  end
end

VolunteerApp::Application.config.secret_key_base = secure_token