require 'rails_helper'

RSpec.describe ShippingController, type: :controller do
  let(:post_params) do
    { "origin" => {"country" => "US","state" => "WA","city" => "Seattle","postal_code" => "98102"},
      "destination" => {"country" => "US","state" => "CA","city" => "Los Angeles","postal_code" => "90024"},
      "package" => {"weight" => 100,"length" => 93,"width" => 10,"height" => 108, "cylinder" => false}
    }
  end
  describe "POST 'fedex'" do
    it "is successful" do
      post :fedex_rates, post_params
      expect(response.response_code).to eq 200
    end

    it "returns json" do
      post :fedex_rates, post_params
      expect(response.header['Content-Type']).to include 'application/json'
    end

    context "the returned json object" do
      before :each do
        # get :search, query: "Rosa"
        @response = JSON.parse response.body
      end

      # it "has the right keys" do
      #   expect(@response[0].keys.sort).to eq keys
      # end
      #
      # it "has all of Rosalita's info" do
      #   keys.each do |key|
      #     expect(@response[0][key]).to eq rosa[key]
      #   end
      # end
    end

    context "no rates found" do
      # before :each do
      #   get :search, query: "Fido"
      # end
      #
      # it "is successful" do
      #   expect(response).to be_successful
      # end
      #
      # it "returns a 204 (no content)" do
      #   expect(response.response_code).to eq 204
      # end
      #
      # it "expects the response body to be an empty array" do
      #   expect(response.body).to eq "[]"
      # end
    end
  end
end
