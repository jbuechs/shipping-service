require 'rails_helper'
require 'support/vcr_setup'

RSpec.describe ShippingController, type: :controller do
  let(:post_params) do
    { "origin" => {"country" => "US","state" => "WA","city" => "Seattle","postal_code" => "98102"},
      "destination" => {"country" => "US","state" => "CA","city" => "Los Angeles","postal_code" => "90024"},
      "package" => {"weight" => 10,"length" => 3,"width" => 10,"height" => 3, "cylinder" => false}
    }
  end
  # describe "POST 'fedex'" do
  #   it "is successful" do
  #     post :fedex_rates, post_params
  #     expect(response.response_code).to eq 200
  #   end
  #
  #   it "returns json" do
  #     post :fedex_rates, post_params
  #     expect(response.header['Content-Type']).to include 'application/json'
  #   end
  #
  #   context "the returned json object" do
  #     before :each do
  #       post :fedex_rates, post_params
  #       @response = JSON.parse response.body
  #       binding.pry
  #     end
  #   end
  #
  #   context "no rates found" do
  #
  #   end
  # end

  describe "POST 'ups'", :vcr do
    it "is successful" do
      post :ups_rates, post_params
      expect(response.response_code).to eq 200
    end

    it "returns json" do
      post :ups_rates, post_params
      expect(response.header['Content-Type']).to include 'application/json'
    end

    context "the returned json object" do
      before :each do
        post :ups_rates, post_params
        @response = JSON.parse response.body
        binding.pry
      end
    end

    context "no rates found" do
      # add error messages
    end
  end
end
