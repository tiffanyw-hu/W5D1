require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  let(:sign_in_sally) do

  end

  scenario 'has a new user page' do
    visit(new_user_url)
    expect(page).to have_content('Sign Up')
  end

  feature 'signing up a user' do
    scenario 'shows username on the homepage after signup' do
      sign_up_sally
      expect(page).to have_content('Sally')
    end

  end
end

feature 'logging in' do
  scenario 'shows username on the homepage after login' do
    sign_in_sally
    expect(page).to have_content('Sally')
  end

end

feature 'logging out' do
  scenario 'begins with a logged out state' do
    visit(new_session_url)
    expect(page).to have_content('Sign In')
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    sign_up_sally

    click_on('Sign Out')
    expect(page).not_to have_content('Sally')
  end

end
