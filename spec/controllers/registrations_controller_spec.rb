require 'rails_helper'

describe Users::RegistrationsController, type: :controller do

  describe 'GET #index' do
    it "indexアクションでindex.html.erbに遷移するか" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      get :index
      expect(response).to render_template "users/registrations/index"
    end
  end

  describe 'GET #basic_information' do
    it "basic_informationアクションでbasic_information.html.erbに遷移するか" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      get :basic_information
      expect(response).to render_template "users/registrations/basic_information"
    end
  end

  describe 'GET #sns_basic_information' do
    it "sns_basic_informationアクションでsns_basic_information.html.erbに遷移するか" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      get :sns_basic_information
      expect(response).to render_template "users/registrations/sns_basic_information"
    end
  end

  describe 'GET #residence' do
    it "residenceアクションでresidence.html.erbに遷移するか" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      get :residence
      expect(response).to render_template "users/registrations/residence"
    end
  end

  describe 'GET #payment' do
    it "paymentアクションでpayment.html.erbに遷移するか" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      get :payment
      expect(response).to render_template "users/registrations/payment"
    end
  end
end
