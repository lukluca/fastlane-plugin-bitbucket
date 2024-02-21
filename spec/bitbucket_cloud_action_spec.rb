describe Fastlane::Actions::BitbucketCreatePullRequestAction do
  describe '#run' do
    after do
      Fastlane::FastFile.new.parse('lane :test do
        Actions.lane_context[SharedValues::BITBUCKET_CREATE_PULL_REQUEST_RESULT] = nil
      end').runner.execute(:test)
    end

    it 'raises an error if username was not given' do
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

    it 'raises an error if password was not given' do
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

    it 'raises an error if company host name was not given' do
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

    it 'raises an error if repository name was not given' do
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

    it 'raises an error if title was not given' do
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

    it 'raises an error if empty username was given' do
      expect do
        Fastlane::FastFile.new.parse("
        lane :test do
          bitbucket_create_pull_request(
            username: '',
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
      end.to raise_error("No value found for 'username'")
    end

    it 'raises an error if empty password was given' do
      expect do
        Fastlane::FastFile.new.parse("
        lane :test do
          bitbucket_create_pull_request(
            username: 'my_username',
            password: '',
            company_host_name: 'myCompany',
            repository_name: 'myRepo',
            title: 'new feature title',
            description: 'new feature description',
            reviewers: ['l.t', 'k.s'],
            source_branch: 'feture/new',
            destination_branch: 'develop'
        )
        end").runner.execute(:test)
      end.to raise_error("No value found for 'password'")
    end

    it 'raises an error if empty company host name was given' do
      expect do
        Fastlane::FastFile.new.parse("
        lane :test do
          bitbucket_create_pull_request(
            username: 'my_username',
            password: 'my_password',
            company_host_name: '',
            repository_name: 'myRepo',
            title: 'new feature title',
            description: 'new feature description',
            reviewers: ['l.t', 'k.s'],
            source_branch: 'feture/new',
            destination_branch: 'develop'
        )
        end").runner.execute(:test)
      end.to raise_error("No value found for 'company_host_name'")
    end

    it 'raises an error if empty repository name was given' do
      expect do
        Fastlane::FastFile.new.parse("
        lane :test do
          bitbucket_create_pull_request(
            username: 'my_username',
            password: 'my_password',
            company_host_name: 'myCompany',
            repository_name: '',
            title: 'new feature title',
            description: 'new feature description',
            reviewers: ['l.t', 'k.s'],
            source_branch: 'feture/new',
            destination_branch: 'develop'
        )
        end").runner.execute(:test)
      end.to raise_error("No value found for 'repository_name'")
    end

    it 'raises an error if empty title was given' do
      expect do
        Fastlane::FastFile.new.parse("
        lane :test do
          bitbucket_create_pull_request(
            username: 'my_username',
            password: 'my_password',
            company_host_name: 'myCompany',
            repository_name: 'myRepo',
            title: '',
            description: 'new feature description',
            reviewers: ['l.t', 'k.s'],
            source_branch: 'feture/new',
            destination_branch: 'develop'
        )
        end").runner.execute(:test)
      end.to raise_error("No value found for 'title'")
    end

    context 'with required fields' do
      it 'succeeds with all variables given through invocation.' do
        body = "{\"title\":\"new feature title\",\"source\":{\"branch\":{\"name\":\"feture/new\"}},\"destination\":{\"branch\":{\"name\":\"develop\"}},\"description\":\"new feature description\",\"reviewers\":[{\"uuid\":\"l.t\"},{\"uuid\":\"k.s\"}]}"

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
        expect(response).to eq({ body: "", json: {}, reason_phrase: "", status: 201 })
      end

      it 'succeeds with required variables given through invocation.' do
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
        expect(response).to eq({ body: "", json: {}, reason_phrase: "", status: 201 })
      end

      it 'fails with required variables given through invocation.' do
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
        expect(e.message).to eq('Plugin Bitbucket finished with error code 401 ')
      end
    end

    it 'supports all platforms' do
      expect(described_class.is_supported?(:ios)).to be(true)
      expect(described_class.is_supported?(:android)).to be(true)
      expect(described_class.is_supported?(:mac)).to be(true)
    end

    it 'has correct description' do
      expect(described_class.description).to eq('Create a new pull request inside your Bitbucket project')
    end

    it 'has correct details' do
      expect(described_class.details).to eq('Wrapper of Bitbucket cloud rest apis in order to make easy integration of Bitbucket CI inside fastlane workflow')
    end

    it 'has correct authors' do
      expect(described_class.authors).to eq(['Luca Tagliabue'])
    end

    it 'has correct output' do
      expect(described_class.output).to eq([['BITBUCKET_CREATE_PULL_REQUEST_RESULT', 'The result of the bitbucket pullrequests cloud api']])
    end

    it 'has correct return_value' do
      expect(described_class.return_value).to eq('The result of the bitbucket pullrequests cloud api')
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

describe Fastlane::Actions::BitbucketListDefaultReviewersAction do
  describe '#run' do
    after do
      Fastlane::FastFile.new.parse("lane :test do
        Actions.lane_context[SharedValues::BITBUCKET_LIST_DEFAULT_REVIEWERS_RESULT] = nil
      end").runner.execute(:test)
    end

    it 'raises an error if username was not given' do
      expect do
        Fastlane::FastFile.new.parse("
        lane :test do
          bitbucket_list_default_reviewers(
            password: 'YOUR_PASSWORD_HERE',
            company_host_name: 'YOUR_COMPANY_HOST_HERE',
            repository_name: 'YOUR_REPOSITORY_NAME_HERE'
        )
        end").runner.execute(:test)
      end.to raise_error("No value found for 'username'")
    end

    it 'raises an error if password was not given' do
      expect do
        Fastlane::FastFile.new.parse("
        lane :test do
          bitbucket_list_default_reviewers(
            username: 'YOUR_USERNAME_HERE',
            company_host_name: 'YOUR_COMPANY_HOST_HERE',
            repository_name: 'YOUR_REPOSITORY_NAME_HERE'
        )
        end").runner.execute(:test)
      end.to raise_error("No value found for 'password'")
    end

    it 'raises an error if company host name was not given' do
      expect do
        Fastlane::FastFile.new.parse("
        lane :test do
          bitbucket_list_default_reviewers(
            username: 'YOUR_USERNAME_HERE',
            password: 'YOUR_PASSWORD_HERE',
            repository_name: 'YOUR_REPOSITORY_NAME_HERE'
        )
        end").runner.execute(:test)
      end.to raise_error("No value found for 'company_host_name'")
    end

    it 'raises an error if repository name was not given' do
      expect do
        Fastlane::FastFile.new.parse("
        lane :test do
          bitbucket_list_default_reviewers(
            username: 'YOUR_USERNAME_HERE',
            password: 'YOUR_PASSWORD_HERE',
            company_host_name: 'YOUR_COMPANY_HOST_HERE'
        )
        end").runner.execute(:test)
      end.to raise_error("No value found for 'repository_name'")
    end

    context 'with required fields' do
      it 'succeeds with required variables given through invocation.' do
        stub_success_get_default_reviewers_list

        response = Fastlane::FastFile.new.parse("
            lane :test do
              bitbucket_list_default_reviewers(
                username: 'my_user',
                password: 'my_password',
                company_host_name: 'myCompany',
                repository_name: 'myRepo'
            )
          end").runner.execute(:test)
        expect(response).to eq({ body: "", json: {}, reason_phrase: "", status: 200 })
      end

      it 'fails with required variables given through invocation.' do
        stub_failed_get_default_reviewers_list

        Fastlane::FastFile.new.parse("
              lane :test do
                bitbucket_list_default_reviewers(
                  username: 'my_user',
                  password: 'my_password',
                  company_host_name: 'myCompany',
                  repository_name: 'myRepo'
                )
              end").runner.execute(:test)
      rescue StandardError => e
        expect(e.message).to eq('Plugin Bitbucket finished with error code 401 ')
      end
    end

    it 'supports all platforms' do
      expect(described_class.is_supported?(:ios)).to be(true)
      expect(described_class.is_supported?(:android)).to be(true)
      expect(described_class.is_supported?(:mac)).to be(true)
    end

    it 'has correct description' do
      expect(described_class.description).to eq('List of all defaults reviewers of pull requests')
    end

    it 'has correct details' do
      expect(described_class.details).to eq('Wrapper of Bitbucket cloud rest apis in order to make easy integration of Bitbucket CI inside fastlane workflow')
    end

    it 'has correct authors' do
      expect(described_class.authors).to eq(['Luca Tagliabue'])
    end

    it 'has correct output' do
      expect(described_class.output).to eq([['BITBUCKET_LIST_DEFAULT_REVIEWERS_RESULT', 'The result of the bitbucket default-reviewers cloud api']])
    end

    it 'has correct return_value' do
      expect(described_class.return_value).to eq('The result of the bitbucket default-reviewers cloud api')
    end
  end
end

def stub_success_get_default_reviewers_list
  stub_request(:get, "https://api.bitbucket.org/2.0/repositories/myCompany/myRepo/default-reviewers").
    with(
      headers: {
        'Authorization' => 'Basic bXlfdXNlcjpteV9wYXNzd29yZA==',
        'Content-Type' => 'application/json',
        'Host' => 'api.bitbucket.org:443'
      }
    ).
    to_return(status: 200,
              body: '',
              headers: {})
end

def stub_failed_get_default_reviewers_list
  stub_request(:get, "https://api.bitbucket.org/2.0/repositories/myCompany/myRepo/default-reviewers").
    with(
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
