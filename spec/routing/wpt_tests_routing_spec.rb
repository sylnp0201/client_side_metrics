require "spec_helper"

describe WptTestsController do
  describe "routing" do

    it "routes to #index" do
      get("/wpt_tests").should route_to("wpt_tests#index")
    end

    it "routes to #new" do
      get("/wpt_tests/new").should route_to("wpt_tests#new")
    end

    it "routes to #show" do
      get("/wpt_tests/1").should route_to("wpt_tests#show", :id => "1")
    end

    it "routes to #edit" do
      get("/wpt_tests/1/edit").should route_to("wpt_tests#edit", :id => "1")
    end

    it "routes to #create" do
      post("/wpt_tests").should route_to("wpt_tests#create")
    end

    it "routes to #update" do
      put("/wpt_tests/1").should route_to("wpt_tests#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/wpt_tests/1").should route_to("wpt_tests#destroy", :id => "1")
    end

  end
end
