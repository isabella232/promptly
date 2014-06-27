require_relative '../acceptance_helper'

feature "Conversations" do
  before do
    @user = FactoryGirl.create :user_with_organization
    @user.organizations_user.first.update_attributes(roles_mask: 1)
  end

  scenario "showing the page when not logged in" do
    visit "/admin/organizations/#{@user.organizations.first.id}/conversations"
    expect(page.current_path).to eq "/"
    expect(page).to have_content "Promptly"
  end

  scenario "showing the page when logged in" do
    sign_in @user
    visit "/admin/organizations/#{@user.organizations.first.id}/conversations"
    expect(page.current_path).to eq "/admin/organizations/#{@user.organizations.first.id}/conversations"
    expect(page).to have_content "Conversations"
    expect(page).to have_content "Responses"
    expect(page).to have_content "Undelivered"
  end
end
