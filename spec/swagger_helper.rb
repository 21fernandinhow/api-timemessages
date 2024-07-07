# spec/swagger_helper.rb

require 'rails_helper'
require 'rspec/rails'

RSpec.configure do |config|
  config.swagger_root = Rails.root.to_s + '/swagger'

  config.swagger_docs = {
    'v1/swagger.json' => {
      openapi: '3.0.1',
      info: {
        title: 'Time Capsule API',
        version: 'v1',
        description: 'API for managing time messages in a time capsule'
      },
      paths: {}
    }
  }
end

# Endpoint definitions
RSpec.describe 'TimeMessages API', type: :request do
  path '/time_messages' do
    post 'Create a TimeMessage' do
      tags 'TimeMessages'
      consumes 'application/json'
      parameter name: :time_message, in: :body, schema: {
        type: :object,
        properties: {
          user_email: { type: :string },
          content: { type: :string },
          date_to_open: { type: :string, format: 'date-time' }
        },
        required: [ 'user_email', 'content', 'date_to_open' ]
      }

      response '201', 'time_message created' do
        let(:time_message) { { user_email: 1, content: 'A message to the future', date_to_open: '2025-01-01T00:00:00Z' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:time_message) { { user_email: 1 } }
        run_test!
      end
    end

    get 'List all TimeMessages' do
      tags 'TimeMessages'
      produces 'application/json'

      response '200', 'list of time_messages' do
        run_test!
      end
    end
  end

  path '/time_messages/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Retrieves a TimeMessage' do
      tags 'TimeMessages'
      produces 'application/json'

      response '200', 'time_message found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            user_email: { type: :integer },
            content: { type: :string },
            date_to_open: { type: :string, format: 'date-time' }
          },
          required: [ 'id', 'user_email', 'content', 'date_to_open' ]

        let(:id) { TimeMessage.create(user_email: 1, content: 'A message to the future', date_to_open: '2025-01-01T00:00:00Z').id }
        run_test!
      end

      response '404', 'time_message not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    patch 'Updates a TimeMessage' do
      tags 'TimeMessages'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :time_message, in: :body, schema: {
        type: :object,
        properties: {
          content: { type: :string },
          date_to_open: { type: :string, format: 'date-time' }
        }
      }

      response '200', 'time_message updated' do
        let(:id) { TimeMessage.create(user_email: 1, content: 'A message to the future', date_to_open: '2025-01-01T00:00:00Z').id }
        let(:time_message) { { content: 'Updated message', date_to_open: '2025-12-31T00:00:00Z' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:id) { 'invalid' }
        let(:time_message) { { content: '' } }
        run_test!
      end
    end

    delete 'Deletes a TimeMessage' do
      tags 'TimeMessages'
      parameter name: :id, in: :path, type: :integer

      response '200', 'time_message deleted' do
        let(:id) { TimeMessage.create(user_email: 1, content: 'A message to delete', date_to_open: '2025-01-01T00:00:00Z').id }
        run_test!
      end

      response '404', 'time_message not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end

RSpec.describe 'Users API', type: :request do
  path '/users' do
    get 'List all Users' do
      tags 'Users'
      produces 'application/json'

      response '200', 'list of users' do
        run_test!
      end
    end

    post 'Create a User' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string }
        },
        required: [ 'email' ]
      }

      response '201', 'user created' do
        let(:user) { { email: 'test@example.com' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { } }
        run_test!
      end
    end
  end

  path '/users/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Retrieves a User' do
      tags 'Users'
      produces 'application/json'

      response '200', 'user found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            email: { type: :string }
          },
          required: [ 'id', 'email' ]

        let(:id) { User.create(email: 'test@example.com').id }
        run_test!
      end

      response '404', 'user not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    patch 'Updates a User' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string }
        }
      }

      response '200', 'user updated' do
        let(:id) { User.create(email: 'test@example.com').id }
        let(:user) { { email: 'updated@example.com' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:id) { 'invalid' }
        let(:user) { { email: '' } }
        run_test!
      end
    end

    delete 'Deletes a User' do
      tags 'Users'
      parameter name: :id, in: :path, type: :integer

      response '204', 'user deleted' do
        let(:id) { User.create(email: 'test@example.com').id }
        run_test!
      end

      response '404', 'user not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
