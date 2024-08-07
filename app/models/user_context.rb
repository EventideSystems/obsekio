# frozen_string_literal: true

# Context object for user and related objects, used by policies to determine access to resources.
class UserContext
  attr_reader :user, :workspace, :checklist, :true_user

  def initialize(user:, true_user: nil)
    @user = user
    @true_user = true_user
  end

  delegate :id, :admin?, to: :user
end
