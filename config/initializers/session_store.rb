# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_twitter-clone-app_session',
  :secret      => '6ddc903f3115011d29f716ee0114c1cc97a64ea3d305f613b6099dcbe3a0c32f9deacd36ad624d217e249f2b776ce23a5af2cda9909cedc8657aaa5213ad9ea2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
