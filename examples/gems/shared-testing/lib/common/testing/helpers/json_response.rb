# frozen_string_literal: true

module Common::Testing
  module JSONResponse
    # Return cached parsed request response
    def json_response
      @json_response ||= begin
        # ensure request has been made
        request
        JSON.parse(response.body)
      end
    end
  end
end
