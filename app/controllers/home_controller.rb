# frozen_string_literal: true

# Home controller presents the landing page for the application (when no user is signed in),
# and the dashboard (when a user is signed in).
class HomeController < ApplicationController
  skip_before_action :authenticate_user!, raise: false
  before_action :load_workspace, only: :index

  group :workspace

  # def index = render(template, layout:)

  def index
    if user_signed_in?
      redirect_to personal_workspaces_path
    else
      render 'landing_page', layout: 'landing_page'
    end
  end

  private

  def template
    user_signed_in? ? 'dashboard' : 'landing_page'
  end

  def layout
    user_signed_in? ? 'application' : 'landing_page'
  end

  def load_workspace
    return unless user_signed_in?

    @checklists = current_user.checklists
  end
end
