describe Fastlane::Actions::BitbucketCreatePullRequestAction do
  describe '#run' do
    after :each do
      Fastlane::FastFile.new.parse("lane :test do
        Actions.lane_context[SharedValues::BITBUCKET_CREATE_PULL_REQUEST_RESULT] = nil
      end").runner.execute(:test)
    end

    it "raises an error if no username was given" do
      expect do
        Fastlane::FastFile.new.parse("
        lane :test do
          bitbucket_create_pull_request(
            password: 'YOUR_PASSWORD_HERE',
            company_host_name: 'YOUR_COMPANY_HOST_HERE',
            repository_name: 'YOUR_REPOSITORY_NAME_HERE',
            title: 'PULL_REQUEST_TITLE_HERE',
            description: 'PULL_REQUEST_DESCRIPTION_HERE',
            reviewers: ['FIRST_REVIEWER', 'SECOND_REVIEWER'],
            source_branch: 'YOUR_SOURCE_BRANCH_HERE',
            destination_branch: 'YOUR_DESTINATION_BRANCH_HERE'
        )
        end").runner.execute(:test)
      end.to raise_error("No value found for 'username'")
    end

    it "raises an error if no password was given" do
      expect do
        Fastlane::FastFile.new.parse("
        lane :test do
          bitbucket_create_pull_request(
            username: 'YOUR_USERNAME_HERE',
            company_host_name: 'YOUR_COMPANY_HOST_HERE',
            repository_name: 'YOUR_REPOSITORY_NAME_HERE',
            title: 'PULL_REQUEST_TITLE_HERE',
            description: 'PULL_REQUEST_DESCRIPTION_HERE',
            reviewers: ['FIRST_REVIEWER', 'SECOND_REVIEWER'],
            source_branch: 'YOUR_SOURCE_BRANCH_HERE',
            destination_branch: 'YOUR_DESTINATION_BRANCH_HERE'
        )
        end").runner.execute(:test)
      end.to raise_error("No value found for 'password'")
    end

    it "raises an error if no company host name was given" do
      expect do
        Fastlane::FastFile.new.parse("
        lane :test do
          bitbucket_create_pull_request(
            username: 'YOUR_USERNAME_HERE',
            password: 'YOUR_PASSWORD_HERE',
            repository_name: 'YOUR_REPOSITORY_NAME_HERE',
            title: 'PULL_REQUEST_TITLE_HERE',
            description: 'PULL_REQUEST_DESCRIPTION_HERE',
            reviewers: ['FIRST_REVIEWER', 'SECOND_REVIEWER'],
            source_branch: 'YOUR_SOURCE_BRANCH_HERE',
            destination_branch: 'YOUR_DESTINATION_BRANCH_HERE'
        )
        end").runner.execute(:test)
      end.to raise_error("No value found for 'company_host_name'")
    end

    it "raises an error if no repository name was given" do
      expect do
        Fastlane::FastFile.new.parse("
        lane :test do
          bitbucket_create_pull_request(
            username: 'YOUR_USERNAME_HERE',
            password: 'YOUR_PASSWORD_HERE',
            company_host_name: 'YOUR_COMPANY_HOST_HERE',
            title: 'PULL_REQUEST_TITLE_HERE',
            description: 'PULL_REQUEST_DESCRIPTION_HERE',
            reviewers: ['FIRST_REVIEWER', 'SECOND_REVIEWER'],
            source_branch: 'YOUR_SOURCE_BRANCH_HERE',
            destination_branch: 'YOUR_DESTINATION_BRANCH_HERE'
        )
        end").runner.execute(:test)
      end.to raise_error("No value found for 'repository_name'")
    end

    it "raises an error if no title was given" do
      expect do
        Fastlane::FastFile.new.parse("
        lane :test do
          bitbucket_create_pull_request(
            username: 'YOUR_USERNAME_HERE',
            password: 'YOUR_PASSWORD_HERE',
            company_host_name: 'YOUR_COMPANY_HOST_HERE',
            repository_name: 'YOUR_REPOSITORY_NAME_HERE',
            description: 'PULL_REQUEST_DESCRIPTION_HERE',
            reviewers: ['FIRST_REVIEWER', 'SECOND_REVIEWER'],
            source_branch: 'YOUR_SOURCE_BRANCH_HERE',
            destination_branch: 'YOUR_DESTINATION_BRANCH_HERE'
        )
        end").runner.execute(:test)
      end.to raise_error("No value found for 'title'")
    end

    context "with required fields" do
      it "succeeds with all variables given through invocation." do
        body = "{\"title\":\"new feature title\",\"source\":{\"branch\":{\"name\":\"feture/new\"}},\"destination\":{\"branch\":{\"name\":\"develop\"}},\"description\":\"new feature description\",\"reviewers\":[{\"username\":\"l.t\"},{\"username\":\"k.s\"}]}"

        stub_success_post_pull_request(body)

        response = Fastlane::FastFile.new.parse("
            lane :test do
              bitbucket_create_pull_request(
                username: 'my_user',
                password: 'my_password',
                company_host_name: 'myCompany',
                repository_name: 'myRepo',
                title: 'new feature title',
                description: 'new feature description',
                reviewers: ['l.t', 'k.s'],
                source_branch: 'feture/new',
                destination_branch: 'develop'
            )
          end").runner.execute(:test)
        expect(!response.nil?)
        expect(!ENV["BITBUCKET_CREATE_PULL_REQUEST_RESULT"].nil?)
      end

      it "succeeds with required variables given through invocation." do
        body = "{\"title\":\"new feature title\",\"source\":{\"branch\":{\"name\":\"feture/new\"}}}"

        stub_success_post_pull_request(body)

        response = Fastlane::FastFile.new.parse("
            lane :test do
              bitbucket_create_pull_request(
                username: 'my_user',
                password: 'my_password',
                company_host_name: 'myCompany',
                repository_name: 'myRepo',
                title: 'new feature title',
                source_branch: 'feture/new'
            )
          end").runner.execute(:test)
        expect(!response.nil?)
        expect(!ENV["BITBUCKET_CREATE_PULL_REQUEST_RESULT"].nil?)
        expect(ENV["BITBUCKET_CREATE_PULL_REQUEST_RESULT"] == "Status code: 201, reason:")
      end

      it "fails with required variables given through invocation." do
        body = "{\"title\":\"new failure feature title\",\"source\":{\"branch\":{\"name\":\"feture/new\"}}}"

        sub_failed_post_pull_request(body)

        Fastlane::FastFile.new.parse("
              lane :test do
                bitbucket_create_pull_request(
                  username: 'my_user',
                  password: 'my_password',
                  company_host_name: 'myCompany',
                  repository_name: 'myRepo',
                  title: 'new failure feature title',
                  source_branch: 'feture/new'
                )
              end").runner.execute(:test)
      rescue StandardError => e
        expect(!ENV["BITBUCKET_CREATE_PULL_REQUEST_RESULT"].nil?)
        expect(ENV["BITBUCKET_CREATE_PULL_REQUEST_RESULT"] == "Status code: 401, reason:")
      end
    end

    it "supports all platforms" do
      expect(Fastlane::Actions::BitbucketCreatePullRequestAction.is_supported?(:ios)).to be(true)
      expect(Fastlane::Actions::BitbucketCreatePullRequestAction.is_supported?(:android)).to be(true)
      expect(Fastlane::Actions::BitbucketCreatePullRequestAction.is_supported?(:mac)).to be(true)
    end
  end
end

def stub_success_post_pull_request(body)
  stub_request(:post, "https://api.bitbucket.org/2.0/repositories/myCompany/myRepo/pullrequests").
    with(
      body: body,
      headers: {
        'Authorization' => 'Basic bXlfdXNlcjpteV9wYXNzd29yZA==',
        'Content-Type' => 'application/json',
        'Host' => 'api.bitbucket.org:443'
      }
    ).
    to_return(status: 201,
              body: '',
              headers: {})
end

def sub_failed_post_pull_request(body)
  stub_request(:post, "https://api.bitbucket.org/2.0/repositories/myCompany/myRepo/pullrequests").
    with(
      body: body,
      headers: {
        'Authorization' => 'Basic bXlfdXNlcjpteV9wYXNzd29yZA==',
        'Content-Type' => 'application/json',
        'Host' => 'api.bitbucket.org:443'
      }
    ).
    to_return(status: 401,
              body: '',
              headers: {})
end
