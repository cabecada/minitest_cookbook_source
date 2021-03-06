require "test_helper"

describe UsersController do
  before do
    login_as(users(:lumbergh))
  end

  let(:user) { users :milton }

  describe "GET index" do
    it "responds with :success" do
      get :index
      must_respond_with :success
    end
  end

  describe "GET show" do
    it "responds with :success" do
      get :show, params: { id: user.id }
      must_respond_with :success
    end
  end

  describe "GET new" do
    it "responds with :success" do
      get :new
      must_respond_with :success
    end
  end

  describe "GET edit" do
    it "responds with :success" do
      get :edit, params: { id: user.id }
      must_respond_with :success
    end
  end

  describe "POST create" do
    describe "with valid parameters" do
      let(:options) { {name: "pgibbons", password: "secret",
                       password_confirmation: "secret"} }

      it "saves the record and redirects to the detail page" do
        assert_difference "User.count" do
          post :create, params: { user: options }
        end

        user = User.find_by name: "pgibbons"    # :name must be unique
        must_redirect_to user
        expect(flash[:notice]).must_equal "User #{ user.name } was successfully created."
      end
    end

    describe "with invalid parameters" do
      let(:options) { {name: "pgibbons"} }

      it "does not save the record and re-displays the :new template" do
        assert_no_difference "User.count" do
          post :create, params: { user: options }
        end
        must_respond_with :success
      end
    end
  end

  describe "PATCH update" do
    describe "with valid parameters" do
      let(:options)  { {name: "pgibbons"} }

      it "updates the record and redirects to the detail page" do
        put :update, params: { id: user.id, user: options }

        user = User.order(updated_at: :desc).first
        must_redirect_to user
        expect(flash[:notice]).must_equal "User #{ user.name } was successfully updated."
      end
    end

    describe "with invalid parameters" do
      let(:options)  { {name: "lumbergh"} }

      it "does not update the record and re-displays the :edit template" do
        put :update, params: { id: user.id, user: options }
        must_respond_with :success
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the record and redirects to the index" do
      assert_difference "User.count", -1 do
        delete :destroy, params: { id: user.id }
      end
      must_redirect_to users_path
      expect(flash[:notice]).must_equal "User #{ user.name } was successfully destroyed."
    end
  end
end
