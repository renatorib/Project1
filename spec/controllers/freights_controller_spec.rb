require 'spec_helper'

describe FreightsController do

	it { should route(:get, '/freights').to(controller: 'freights', action: 'index') }

	describe 'GET #new' do
    before :each do
    	 sign_in FactoryGirl.create(:user)
    	 get :new
    end

    it { should render_template('new') }
  end

end