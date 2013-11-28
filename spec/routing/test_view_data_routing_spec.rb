require "spec_helper"

describe TestViewDataController do
  describe "routing" do

    it "routes to #index" do
      get("/test_view_data").should route_to("test_view_data#index")
    end

    it "routes to #new" do
      get("/test_view_data/new").should route_to("test_view_data#new")
    end

    it "routes to #show" do
      get("/test_view_data/1").should route_to("test_view_data#show", :id => "1")
    end

    it "routes to #edit" do
      get("/test_view_data/1/edit").should route_to("test_view_data#edit", :id => "1")
    end

    it "routes to #create" do
      post("/test_view_data").should route_to("test_view_data#create")
    end

    it "routes to #update" do
      put("/test_view_data/1").should route_to("test_view_data#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/test_view_data/1").should route_to("test_view_data#destroy", :id => "1")
    end

  end
end
