# frozen_string_literal: true

describe Fastlane::Actions::BitbucketListDefaultReviewersAction do
  describe '#run' do
    after do
      Fastlane::FastFile.new.parse("lane :test do
        Actions.lane_context[SharedValues::BITBUCKET_LIST_DEFAULT_REVIEWERS_RESULT] = nil
      end").runner.execute(:test)
    end

    context 'without required variables raises an error' do
      it 'if username was not given' do
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

      it 'if password was not given' do
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

      it 'if company host name was not given' do
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

      it 'if repository name was not given' do
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

      it 'if empty username was given' do
        expect do
          Fastlane::FastFile.new.parse("
          lane :test do
            bitbucket_list_default_reviewers(
              username: '',
              password: 'my_password',
              company_host_name: 'myCompany',
              repository_name: 'myRepo'
          )
          end").runner.execute(:test)
        end.to raise_error("No value found for 'username'")
      end

      it 'if empty password was given' do
        expect do
          Fastlane::FastFile.new.parse("
          lane :test do
            bitbucket_list_default_reviewers(
              username: 'my_user',
              password: '',
              company_host_name: 'myCompany',
              repository_name: 'myRepo'
          )
          end").runner.execute(:test)
        end.to raise_error("No value found for 'password'")
      end

      it 'if empty company host name was given' do
        expect do
          Fastlane::FastFile.new.parse("
          lane :test do
            bitbucket_list_default_reviewers(
              username: 'my_user',
              password: 'my_password',
              company_host_name: '',
              repository_name: 'myRepo'
          )
          end").runner.execute(:test)
        end.to raise_error("No value found for 'company_host_name'")
      end

      it 'if empty repository name was given' do
        expect do
          Fastlane::FastFile.new.parse("
          lane :test do
            bitbucket_list_default_reviewers(
              username: 'my_user',
              password: 'my_password',
              company_host_name: 'myCompany',
              repository_name: ''
          )
          end").runner.execute(:test)
        end.to raise_error("No value found for 'repository_name'")
      end
    end

    context 'with required variables given through invocation' do
      it 'succeeds' do
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
        expect(response).to eq({ body: '', json: {}, reason_phrase: '', status: 200 })
      end

      it 'fails' do
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

    it 'supports ios' do
      expect(described_class.is_supported?(:ios)).to be(true)
    end

    it 'supports android' do
      expect(described_class.is_supported?(:android)).to be(true)
    end

    it 'supports mac' do
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

# rubocop:disable Metrics/MethodLength
def stub_success_get_default_reviewers_list
  stub_request(:get, 'https://api.bitbucket.org/2.0/repositories/myCompany/myRepo/default-reviewers')
    .with(
      headers: {
        'Authorization' => 'Basic bXlfdXNlcjpteV9wYXNzd29yZA==',
        'Content-Type' => 'application/json',
        'Host' => 'api.bitbucket.org:443'
      }
    )
    .to_return(status: 200,
               body: '',
               headers: {})
end
# rubocop:enable Metrics/MethodLength

# rubocop:disable Metrics/MethodLength
def stub_failed_get_default_reviewers_list
  stub_request(:get, 'https://api.bitbucket.org/2.0/repositories/myCompany/myRepo/default-reviewers')
    .with(
      headers: {
        'Authorization' => 'Basic bXlfdXNlcjpteV9wYXNzd29yZA==',
        'Content-Type' => 'application/json',
        'Host' => 'api.bitbucket.org:443'
      }
    )
    .to_return(status: 401,
               body: '',
               headers: {})
end
# rubocop:enable Metrics/MethodLength
