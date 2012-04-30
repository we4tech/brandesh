require 'spec_helper'

describe ContestRegistrationController do
  describe '#create' do
    context 'without agency association' do
      let(:params) do
        FactoryGirl.attributes_for(:user).merge(
            :agencies_attributes => {
                '0' => FactoryGirl.attributes_for(:agency)
            })
      end

      it 'should create new user' do
        lambda { post :create, :user => params }.
            should change(User, :count).by(1)
      end

      it 'should create new agency' do
        lambda { post :create, :user => params }.
            should change(Agency, :count).by(1)
      end
    end

    context 'with agency association' do
      let!(:agency) { FactoryGirl.create(:agency) }
      let!(:params) do
        FactoryGirl.attributes_for(:user).merge(:agency_ids => [agency.id])
      end

      it 'should create new user' do
        lambda { post :create, :user => params }.
            should change(User, :count).by(1)
      end

      it 'should not create new agency' do
        lambda { post :create, :user => params }.
            should change(Agency, :count).by(0)
      end

      it 'should associate user with agency' do
        post :create, :user => params
        assigns(:user).agencies.should == [agency]
      end
    end
  end
end
