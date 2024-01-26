describe Fastlane::Actions::BitbucketCloudAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The bitbucket_cloud plugin is working!")

      Fastlane::Actions::BitbucketCloudAction.run(nil)
    end
  end
end
