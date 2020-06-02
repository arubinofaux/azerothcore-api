require 'rails_helper'

RSpec.describe "News", type: :request do

  path '/news/create' do

    post 'Create New Article' do
      tags 'local'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :article, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          content: { type: :string }
        },
        required: [ 'title', 'content' ]
      }
      
      response '201', 'success' do
        let(:article) { { title: "Welcome", content: "success" } }
        run_test!
      end

      response '500', 'error' do
        let(:error) { { } }
        run_test!
      end
    end
  end

  path '/news/get' do

    post 'Get single Article' do
      tags 'local'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :article, in: :body, schema: {
        type: :object,
        properties: {
          slug: { type: :string }
        },
        required: [ 'slug' ]
      }
      
      response '200', 'success' do
        let(:character) { { guid: 1 } }
        run_test!
      end

      response '500', 'error' do
        let(:error) { { } }
        run_test!
      end
    end
  end

  path '/news' do

    get 'Get all News Articles' do
      tags 'local'
      produces 'application/json'
      
      response '200', 'success' do
        run_test!
      end

      response '500', 'error' do
        let(:error) { { } }
        run_test!
      end
    end
  end

end
