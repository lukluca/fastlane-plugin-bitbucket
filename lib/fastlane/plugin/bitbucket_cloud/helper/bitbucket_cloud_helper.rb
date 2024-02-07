require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?(:UI)

  module Helper
    class BitbucketCloudHelper
      # class methods that you define here become available in your action
      # as `Helper::BitbucketCloudHelper.your_method`
      #
      def self.url(options)
        company_host_name = options[:company_host_name]
        repository_name = options[:repository_name]
        api = options[:api]

        "https://api.bitbucket.org/2.0/repositories/#{company_host_name}/#{repository_name}/#{api}"
      end

      def self.headers(options)
        api_token = Base64.strict_encode64("#{options[:username]}:#{options[:password]}")

        { "Content-Type": "application/json", Authorization: "Basic #{api_token}" }
      end

      def self.formatted_result(response)
        {
          status: response[:status],
          reason_phrase: response[:reason_phrase],
          body: response.body || "",
          json: self.parse_json(response.body) || {}
        }
      end

      def self.formatted_context_result(response)
        "Status code: #{response[:status]}, reason: #{response[:reason_phrase]}"
      end

      def self.parse_json(value)
        require 'json'

        JSON.parse(value)
      rescue JSON::ParserError
        nil
      end
    end
  end
end
