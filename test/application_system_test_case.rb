require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]
  setup do
    Capybara.server_host = "0.0.0.0" # bind to all interfaces
    Capybara.app_host    = "http://#{IPSocket.getaddress(Socket.gethostname)}" if ENV["SELENIUM_REMOTE_URL"].present?
  end
  url     = ENV.fetch("SELENIUM_REMOTE_URL", nil)
  options =
    if url
      { browser: :remote, url: url }
    else
      { browser: :chrome }
    end
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ], options: options
end
