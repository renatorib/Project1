require 'spec_helper'

describe FreightsController do

	describe 'GET #new' do
    before { get :new }
    it { should render_template('new') }
  end

	it { should route(:get, '/freights').to(controller: 'freights', action: 'index') }
	
end