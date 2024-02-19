# frozen_string_literal: true

# Home controller presents the landing page for the application (when no user is signed in),
# and the dashboard (when a user is signed in).
class HomeController < ApplicationController
  skip_before_action :authenticate_user!, raise: false

  def index = render(template)

  private

  def template
    user_signed_in? ? 'dashboard' : 'landing_page'
  end
end