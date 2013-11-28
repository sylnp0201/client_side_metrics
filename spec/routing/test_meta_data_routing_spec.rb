require "spec_helper"

describe TestMetaDataController do
  describe "routing" do

    it "routes to #index" do
      get("/test_meta_data").should route_to("test_meta_data#index")
    end

    it "routes to #new" do
      get("/test_meta_data/new").should route_to("test_meta_data#new")
    end

    it "routes to #show" do
      get("/test_meta_data/1").should route_to("test_meta_data#show", :id => "1")
    end

    it "routes to #edit" do
      get("/test_meta_data/1/edit").should route_to("test_meta_data#edit", :id => "1")
    end

    it "routes to #create" do
      post("/test_meta_data").should route_to("test_meta_data#create")
    end

    it "routes to #update" do
      put("/test_meta_data/1").should route_to("test_meta_data#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/test_meta_data/1").should route_to("test_meta_data#destroy", :id => "1")
    end

  end
end
