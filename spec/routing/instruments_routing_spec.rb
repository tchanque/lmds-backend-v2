require "rails_helper"

RSpec.describe InstrumentsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/instruments").to route_to("instruments#index")
    end

    it "routes to #show" do
      expect(get: "/instruments/1").to route_to("instruments#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/instruments").to route_to("instruments#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/instruments/1").to route_to("instruments#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/instruments/1").to route_to("instruments#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/instruments/1").to route_to("instruments#destroy", id: "1")
    end
  end
end
