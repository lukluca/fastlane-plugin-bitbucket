require 'fastlane/action'
require_relative '../helper/bitbucket_helper'

module Fastlane
  module Actions
    module SharedValues
      POST_BITBUCKET_PULL_REQUEST_RESULT = :POST_BITBUCKET_PULL_REQUEST_RESULT
    end
    class PostBitbucketPullRequestAction  < Action
      def self.run(options)
        begin
          require 'excon'

          company_host_name = options[:company_host_name]
          project_key = options[:project_key]
          repository_name = options[:repository_name]

          api_token = Base64.encode64("#{options[:username]}:#{options[:password]}")

          puts "DEBUG api_token"
          puts api_token

          api_url = "https://bitbucket.#{company_host_name}.com/rest/api/1.0/projects/#{project_key}/repos/#{repository_name}/pull-requests"

          headers = { "Content-Type": "application/json", "Authorization": "Basic #{api_token}" }

          puts "DEBUG headers"
          puts headers

          reviewers = options[:reviewers].map { |reviewer| 
              {
                user: {
                   name: reviewer    
                }
              }
            }

          puts "DEBUG reviewers"
          puts reviewers

          payload = {
            title: options[:title],
            description: options[:description],
            state: "OPEN",
            open: true,
            closed: false,
            fromRef: {
                id: options[:source_branch],
                repository: {
                    slug: "my-repo",
                    name: nil,
                    project: {
                        key: "PRJ"
                    }
                }
            },
            toRef: {
                id: options[:destination_branch],
                repository: {
                    slug: "my-repo",
                    name: nil,
                    project: {
                        key: "PRJ"
                    }
                }
            },
            locked: false,
            reviewers: reviewers
          }.to_json

          puts "DEBUG payload"
          puts payload

          puts api_url

          response = Excon.post(api_url, headers: headers, body: payload)
          result = self.formatted_result(response)
        rescue => exception
          UI.error("Exception: #{exception}")
          return nil
        else
          UI.success("Successfully create a new Bitbucket pull request!")
          Actions.lane_context[SharedValues::POST_BITBUCKET_PULL_REQUEST_RESULT] = result
          return result
        end
      end

      def self.formatted_result(response)
        result = {
          status: response[:status],
          body: response.body || "",
          json: self.parse_json(response.body) || {}
        }
      end

      def self.parse_json(value)
        require 'json'

        JSON.parse(value)
      rescue JSON::ParserError
        nil
      end

      def self.description
        "Create a new pull request inside your Bitbucket project"
      end

      def self.details
        "Wrapper of Bitbucket rest apis in order to make easy integration of Bitbucket CI inside fastlane workflow"
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
                                       default_value: ENV["BITBUCKET_USERNAME"],
                                       default_value_dynamic: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :password,
                                       env_name: "FL_POST_BITBUCKET_PULL_REQUEST_PASSWORD",
                                       description: "Bitbucket password",
                                       sensitive: true,
                                       code_gen_sensitive: true,
                                       is_string: true,
                                       default_value: ENV["BITBUCKET_PASSWORD"],
                                       default_value_dynamic: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :company_host_name,
                                       env_name: "FL_POST_BITBUCKET_PULL_REQUEST_COMPANY_HOST_NAME",
                                       description: "Bitbucket company host name",
                                       sensitive: true,
                                       code_gen_sensitive: true,
                                       is_string: true,
                                       default_value: ENV["BITBUCKET_COMPANY_HOST_NAME"],
                                       default_value_dynamic: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :project_key,
                                       env_name: "FL_POST_BITBUCKET_PULL_REQUEST_PROJECT_KEY",
                                       description: "Bitbucket project key",
                                       sensitive: true,
                                       code_gen_sensitive: true,
                                       is_string: true,
                                       default_value: ENV["BITBUCKET_PROJECT_KEY"],
                                       default_value_dynamic: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :repository_name,
                                       env_name: "FL_POST_BITBUCKET_PULL_REQUEST_REPOSITORY_NAME",
                                       description: "Bitbucket repository name",
                                       sensitive: true,
                                       code_gen_sensitive: true,
                                       is_string: true,
                                       default_value: ENV["BITBUCKET_REPOSITORY_NAME"],
                                       default_value_dynamic: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :title,
                                       env_name: "FL_POST_BITBUCKET_PULL_REQUEST_TITLE",
                                       description: "Title of the pull request",
                                       is_string: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :description,
                                       env_name: "FL_POST_BITBUCKET_PULL_REQUEST_DESCRIPTION",
                                       description: "Description of the pull request",
                                       is_string: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :reviewers,
                                       env_name: "FL_POST_BITBUCKET_PULL_REQUEST_REVIEWERS",
                                       description: "List of reviewers for the pull request",
                                       type: Array,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :source_branch,
                                       env_name: "FL_POST_BITBUCKET_PULL_REQUEST_SOURCE_BRANCH",
                                       description: "Name of the source branch",
                                       is_string: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :destination_branch,
                                       env_name: "FL_POST_BITBUCKET_PULL_REQUEST_DESTINATION_BRANCH",
                                       description: "Name of the destination branch",
                                       is_string: true,
                                       optional: false),
        ]
      end

      def self.example_code
        [
          'post_bitbucket_pull_request(
              username: "YOUR_USERNAME_HERE",
              password: "YOUR_PASSWORD_HERE",
              company_host_name: "YOUR_COMPANY_HOST_HERE",
              project_key: "YOUR_PROJECT_KEY_HERE",
              repository_name: "YOUR_REPOSITORY_NAME_HERE",
              title: "PULL_REQUEST_TITLE_HERE",
              description: "PULL_REQUEST_DESCRIPTION_HERE",
              reviewers: ["FIRST_REVIEWER", "SECOND_REVIEWER"],
              source_branch: "YOUR_SOURCE_BRANCH_HERE",
              destination_branch: "YOUR_DESTINATION_BRANCH_HERE"
          )'
        ]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end