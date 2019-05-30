require 'rails_helper'

RSpec.describe 'Task API' do
  before { host! 'api.task-manager.test' }

  let!(:user) { create(:user) }
  let(:headers) do
		{
		  'Content-Type' => Mime[:json].to_s,
		  'Accept' => 'application/vnd.taskmanager.v1',
		  'Authorization' => user.auth_token
		}
  end

  describe 'GET /tasks' do
    before do
      i = 0
      70.times do
        FactoryGirl.create(:task, title: "MaTask#{i}", user_id: user.id)
      end
      get '/tasks', params: {}, headers: headers
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns 5 tasks from database' do
      expect(json_body[:tasks].count).to eq(70)
    end
  end

end