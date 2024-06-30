require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:admin_user) { create(:user, :admin) }
  let(:regular_user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:valid_headers) { auth_headers(admin_user) }
  let(:regular_headers) { auth_headers(regular_user) }
  let(:invalid_headers) { { "Authorization" => "Bearer invalid_token" } }

  describe "GET /index" do
    it "returns http success" do
      get users_path, headers: valid_headers
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get user_path(regular_user), headers: valid_headers
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /update" do
    context "when the user is authorized" do
      it "returns http success" do
        patch user_path(regular_user), params: { user: { first_name: 'Updated' } }, headers: regular_headers
        expect(response).to have_http_status(:success)
      end
    end

    context "when the user is not authorized" do
      it "returns unauthorized status" do
        patch user_path(other_user), params: { user: { first_name: 'Updated' } }, headers: regular_headers
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE /destroy" do
    context "when the user is authorized" do
      it "returns no content status" do
        delete user_path(regular_user), headers: regular_headers
        expect(response).to have_http_status(:no_content)
      end
    end

    context "when the user is not authorized" do
      it "returns unauthorized status" do
        delete user_path(other_user), headers: regular_headers
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "PATCH /change_password" do
    context "when the user is authorized" do
      it "returns http success" do
        patch change_password_user_path(regular_user), params: { user: { current_password: 'Password1!', password: 'NewPassword1!', password_confirmation: 'NewPassword1!' } }, headers: regular_headers
        expect(response).to have_http_status(:ok)
      end
    end

    context "when the user is not authorized" do
      it "returns unauthorized status" do
        patch change_password_user_path(other_user), params: { user: { current_password: 'Password1!', password: 'NewPassword1!', password_confirmation: 'NewPassword1!' } }, headers: regular_headers
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end

def auth_headers(user)
  token = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
  { "Authorization" => "Bearer #{token}" }
end

