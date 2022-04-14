require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/kids", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # Kid. As you add validations to Kid, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Kid.create! valid_attributes
      get kids_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      kid = Kid.create! valid_attributes
      get kid_url(kid)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_kid_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      kid = Kid.create! valid_attributes
      get edit_kid_url(kid)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Kid" do
        expect {
          post kids_url, params: { kid: valid_attributes }
        }.to change(Kid, :count).by(1)
      end

      it "redirects to the created kid" do
        post kids_url, params: { kid: valid_attributes }
        expect(response).to redirect_to(kid_url(Kid.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Kid" do
        expect {
          post kids_url, params: { kid: invalid_attributes }
        }.to change(Kid, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post kids_url, params: { kid: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested kid" do
        kid = Kid.create! valid_attributes
        patch kid_url(kid), params: { kid: new_attributes }
        kid.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the kid" do
        kid = Kid.create! valid_attributes
        patch kid_url(kid), params: { kid: new_attributes }
        kid.reload
        expect(response).to redirect_to(kid_url(kid))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        kid = Kid.create! valid_attributes
        patch kid_url(kid), params: { kid: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested kid" do
      kid = Kid.create! valid_attributes
      expect {
        delete kid_url(kid)
      }.to change(Kid, :count).by(-1)
    end

    it "redirects to the kids list" do
      kid = Kid.create! valid_attributes
      delete kid_url(kid)
      expect(response).to redirect_to(kids_url)
    end
  end
end
