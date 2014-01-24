require 'spec_helper'

describe FreightsController do

	it { should route(:get, '/freights').to(controller: 'freights', action: 'index') }

	describe 'GET #new' do
    before { get :new }
    it { should render_template('new') }
  end

end