require 'fastlane/action'
require_relative '../helper/bitbucket_helper'

module Fastlane
  module Actions
    class BitbucketAction < Action
      def self.run(params)
        UI.message("The bitbucket plugin is working!")
      end

      def self.description
        "Wrapper of Bitbucket rest apis"
      end

      def self.authors
        ["Luca Tagliabue"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "Wrapper of Bitbucket rest apis in order to make easy integration of Bitbucket CI inside fastlane workflow"
      end

      def self.available_options
        [
          # FastlaneCore::ConfigItem.new(key: :your_option,
          #                         env_name: "BITBUCKET_YOUR_OPTION",
          #                      description: "A description of your option",
          #                         optional: false,
          #                             type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
