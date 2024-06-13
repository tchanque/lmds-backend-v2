require "rails_helper"

RSpec.describe EventInstrumentsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/event_instruments").to route_to("event_instruments#index")
    end

    it "routes to #show" do
      expect(get: "/event_instruments/1").to route_to("event_instruments#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/event_instruments").to route_to("event_instruments#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/event_instruments/1").to route_to("event_instruments#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/event_instruments/1").to route_to("event_instruments#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/event_instruments/1").to route_to("event_instruments#destroy", id: "1")
    end
  end
end
