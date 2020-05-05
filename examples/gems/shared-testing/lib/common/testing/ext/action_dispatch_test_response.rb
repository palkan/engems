# frozen_string_literal: true

module ActionDispatch
  # Make response less verbose (for rspec failure messages).
  #
  # Before:
  #   expected `#<ActionDispatch::TestResponse:0x000055c409b14a40
  #               @mon_owner=nil, @mon_count=0,
  #               @mon_mutex=#<Thread::...ext/html", @hash=459027022919608650>,
  #               @charset="utf-8", @cache_control={:no_cache=>true},
  #               @etag=nil>.success?` to return true, got false
  #
  # After:
  #  expected `TestResponse<status: 302, content-type: text/html,
  #                         body: "<html><body>You are being redirected</a>..."
  #                       >.success?` to return true, got false
  class TestResponse
    def inspect
      "TestResponse<status: #{status}, " \
      "content-type: #{content_type}, " \
      "body: \"#{body.truncate(200)}\">"
    end
  end
end
