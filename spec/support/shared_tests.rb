shared_examples_for "a shipping carrier" do
  let(:post_params) do
    { "origin" => {"country" => "US","state" => "WA","city" => "Seattle","postal_code" => "98102"},
      "destination" => {"country" => "US","state" => "CA","city" => "Los Angeles","postal_code" => "90024"},
      "package" => {"weight" => 10,"length" => 3,"width" => 10,"height" => 3, "cylinder" => false}
    }
  end
  let(:invalid_params) do
    { "origin" => {"country" => "US","state" => "WA","city" => "Seattle","postal_code" => "98102"},
      "destination" => {"country" => "US","state" => "CA","city" => "Los Angeles","postal_code" => "90024"},
      "package" => {"weight" => 100,"length" => 300,"width" => 100,"height" => 300, "cylinder" => false}
    }
  end

  describe "POST 'ups'" do
    context "valid params" do
      it "is successful" do
        post carrier_path, post_params
        expect(response.response_code).to eq 200
      end

      it "returns json" do
        post carrier_path, post_params
        expect(response.header['Content-Type']).to include 'application/json'
      end

      # context "the returned json object" do
      #   before :each do
      #     post :ups_rates, post_params
      #     @response = JSON.parse response.body
      #     # binding.pry
      #   end
      #   it "stuff about response" do
      #
      #   end
      # end
    end

    context "invalid params" do
      it "is not successful" do
        post carrier_path, invalid_params
        expect(response.response_code).to eq 204
      end
    end
  end

end
