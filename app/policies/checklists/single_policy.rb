# frozen_string_literal: true

module Checklists
  # Policy for Checklists::Single
  class SinglePolicy < ::ChecklistPolicy
    # Inherit from ChecklistPolicy
    class Scope < ::ChecklistPolicy::Scope
    end
  end
end
