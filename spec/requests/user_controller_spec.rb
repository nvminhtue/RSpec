require 'rails_helper'

describe "GET #show/:id", type: :request do
  let(:user){FactoryBot.create(:user)}
  before{login user}
  # before{get :show, params: {id: user.id}}
  it "assigns the requested user to @user" do
    # session[:user_id] = user.id
    get "/users/1"
    expect(assigns(:user)).to eq(user)
  end

  it "renders the #show view" do
    #get :show, params: {id: FactoryBot.build(:user)}
    get "/users/1"
    session[:user_id] = user.id
    # expect(response).to render_template :show
    expect(response).to render_template("users/show")
    expect(response).to render_template("shared/_search_home")
    expect(response).to render_template("layouts/_header")
    expect(response).to render_template("layouts/_flash")
    expect(response).to render_template("layouts/_footer")
    expect(response).to render_template("layouts/application")
  end
end
describe "GET #new", type: :request do
  it "assigns new user" do
    get "/signup"
    expect(response).to render_template("shared/_error_messages")
    expect(response).to render_template("users/_form")
    expect(response).to render_template("users/new")
    expect(response).to render_template("shared/_search_home")
    expect(response).to render_template("layouts/_header")
    expect(response).to render_template("layouts/_flash")
    expect(response).to render_template("layouts/_footer")
    expect(response).to render_template("layouts/application")
  end
end

describe "GET #edit", type: :request do
  let(:user){FactoryBot.create(:user)}
  before{login user}
  it "edits user" do
    get "/users/1/edit"
    expect(response).to render_template("users/edit")
  end
end

describe "POST #create" do
  context "with valid attributes" do
    user_attributes = FactoryBot.attributes_for(:user, name: "Tue")
    it "successful sign up" do
      expect{
        post "/signup", params: {user: user_attributes}
      }.to change(User, :count).by(1)
    end

    it "redirects to the new contact" do
      post "/signup", params: {user: user_attributes}
      expect(flash[:success]).to match("Welcome Tue to Furniture E-Commerce" )
      expect(response).to redirect_to root_path
    end
  end

  context "with invalid attributes" do
    user_attributes = FactoryBot.attributes_for(:invalid_user)
    it "does not save the new contact" do
      expect{
        post "/signup", params: {user: user_attributes}
      }.to_not change(User,:count)
    end

    it "re-renders the signup form" do
      post "/signup", params: {user: user_attributes}
      expect(flash[:danger]).to match("Invalid infomation")
      expect(response).to render_template("users/new")
    end
  end
end


describe "PUT #update" do
  let(:user){FactoryBot.create(:user, name: "Minh Tue", email: "tue@mail.com")}
  before{login user}
  context  "valid attributes" do
  user_attributes = FactoryBot.attributes_for(:user)
    it "located the requested user" do
      put "/users/1", params: {user: user_attributes}
      expect(assigns(:user)).to eq(user)
    end

    it "chages user's attributes" do
      user_attributes = FactoryBot.attributes_for(:user, name: "Tue")
      put "/users/1", params: {user: user_attributes}
      user.reload
      expect(user.name).to eq ("Tue")
    end

    it "redirects to the updated contact" do
      put "/users/1", params: {user: user_attributes}
      expect(flash[:success]).to match("Successful updated")
      expect(response).to redirect_to user
    end
  end

  context "invalid attributes" do
    it "locates the requested user" do
      user_attributes = FactoryBot.attributes_for(:invalid_user)
      put "/users/1", params: {user: user_attributes}
      expect(assigns(:user)).to eq(user)
    end

    it "does not change user's attributes" do
      user_attributes = FactoryBot.attributes_for(:user, email: "abc@mail.com", name: nil)
      put "/users/1", params: {user: user_attributes}
      user.reload
      expect(user.email).to_not eq("abc@mail.com")
      expect(user.name).to eq("Minh Tue")
    end

    it "re-renders the edit method" do
      user_attributes = FactoryBot.attributes_for(:invalid_user)
      put "/users/1", params: {user: user_attributes}
      expect(response).to render_template("users/edit")
    end
  end
end
