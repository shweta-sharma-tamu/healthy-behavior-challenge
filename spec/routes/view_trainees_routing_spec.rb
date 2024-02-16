require 'rails_helper'

RSpec.describe 'ViewTrainees', type: :routing do
  describe 'routing' do
    it 'routes to view_trainees#index' do
      expect(get: '/view_trainees').to route_to('view_trainees#index')
    end

    it 'routes to view_trainees#profile_details' do
      expect(get: '/view_trainees/1/profile_details').to route_to('view_trainees#profile_details', id: '1')
    end
  end
end
