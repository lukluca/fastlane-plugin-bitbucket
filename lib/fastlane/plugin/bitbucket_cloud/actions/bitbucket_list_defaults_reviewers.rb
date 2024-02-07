require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/bitbucket_cloud_helper'

module Fastlane
  module Actions
    module SharedValues
      BITBUCKET_LIST_DEFAULT_REVIEWERS_RESULT = :BITBUCKET_LIST_DEFAULT_REVIEWERS_RESULT
    end

    class BitbucketListDefaultReviewersAction < Action
      def self.run(options)
        require 'excon'

        api_url = Helper::BitbucketCloudHelper.url(company_host_name: options[:company_host_name], repository_name: options[:repository_name], api: "default-reviewers")

        headers = Helper::BitbucketCloudHelper.headers(username: options[:username], password: options[:password])

        UI.important("Plugin Bitbucket will list all defaults reviewers")

        response = Excon.get(api_url, headers: headers)

        result = Helper::BitbucketCloudHelper.formatted_result(response)

        UI.important("Plugin Bitbucket finished with result")
        UI.important(result.to_s)

        Actions.lane_context[SharedValues::BITBUCKET_LIST_DEFAULT_REVIEWERS_RESULT] = Helper::BitbucketCloudHelper.formatted_context_result(response)

        if result[:status] != 200
          error_message = "Plugin Bitbucket finished with error code #{result[:status]} #{result[:reason_phrase]}"
          raise StandardError, error_message
        end

        UI.success("Successfully list all default reviewers!")
        return result
      end

      def self.description
        "List of all defaults reviewers of pull requests"
      end

      def self.details
        "Wrapper of Bitbucket cloud rest apis in order to make easy integration of Bitbucket CI inside fastlane workflow"
      end

      def self.authors
        ["Luca Tagliabue"]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :username,
                                       env_name: "FL_POST_BITBUCKET_PULL_REQUEST_USERNAME",
                                       description: "Bitbucket username",
                                       sensitive: true,
                                       code_gen_sensitive: true,
                                       is_string: true,
                                       default_value: ENV.fetch("BITBUCKET_USERNAME", nil),
                                       default_value_dynamic: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :password,
                                       env_name: "FL_POST_BITBUCKET_PULL_REQUEST_PASSWORD",
                                       description: "Bitbucket password",
                                       sensitive: true,
                                       code_gen_sensitive: true,
                                       is_string: true,
                                       default_value: ENV.fetch("BITBUCKET_PASSWORD", nil),
                                       default_value_dynamic: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :company_host_name,
                                       env_name: "FL_POST_BITBUCKET_PULL_REQUEST_COMPANY_HOST_NAME",
                                       description: "Bitbucket company host name",
                                       sensitive: true,
                                       code_gen_sensitive: true,
                                       is_string: true,
                                       default_value: ENV.fetch("BITBUCKET_COMPANY_HOST_NAME", nil),
                                       default_value_dynamic: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :repository_name,
                                       env_name: "FL_POST_BITBUCKET_PULL_REQUEST_REPOSITORY_NAME",
                                       description: "Bitbucket repository name",
                                       sensitive: true,
                                       code_gen_sensitive: true,
                                       is_string: true,
                                       default_value: ENV.fetch("BITBUCKET_REPOSITORY_NAME", nil),
                                       default_value_dynamic: true,
                                       optional: false)
        ]
      end

      def self.output
        [
          ['BITBUCKET_LIST_DEFAULT_REVIEWERS_RESULT', 'The result of the bitbucket rest cloud api']
        ]
      end

      def self.return_value
        'The result of the bitbucket rest cloud api'
      end

      def self.example_code
        [
          'bitbucket_list_default_reviewers(
              username: "YOUR_USERNAME_HERE",
              password: "YOUR_PASSWORD_HERE",
              company_host_name: "YOUR_COMPANY_HOST_HERE",
              repository_name: "YOUR_REPOSITORY_NAME_HERE"
          )'
        ]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
