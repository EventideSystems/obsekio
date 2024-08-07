# frozen_string_literal: true

# ChecklistsController
class ChecklistsController < ApplicationController
  before_action :load_checklist, only: %i[show edit update details]
  before_action :set_session_view
  before_action :load_view, only: %i[show]

  around_action :use_logidze_responsible, only: %i[create update]

  sidebar_item :workspace

  def index = @checklists = policy_scope(Checklist)

  def show
    if @checklist.is_a?(Checklists::Concurrent)
      add_breadcrumb(@checklist.title, @checklist.becomes(Checklist))
      add_breadcrumb(@checklist.instance_model_name.titleize.pluralize)
    else
      add_breadcrumb(@checklist.title)
    end
  end

  def new
    @checklist = Checklist.new(owner: current_user)

    add_breadcrumb('New Checklist')
  end

  def create
    @checklist = build_new_checklist

    if @checklist.save
      redirect_to edit_checklist_path(id: @checklist.id)
    else
      add_breadcrumb('New Checklist')

      render :new
    end
  end

  def edit
    add_breadcrumb(@checklist.title)
  end

  def update
    @checklist.update(params_for_checklist.merge(params_for_checklist_data_entry_radio_additional_states))

    redirect_to checklist_path(@checklist)
  end

  # Move to a new controller
  def details
    if @checklist.is_a?(Checklists::Concurrent)
      add_breadcrumb(@checklist.title, @checklist.becomes(Checklist))
      add_breadcrumb(@checklist.instance_model_name.titleize.pluralize)
    else
      add_breadcrumb(@checklist.title)
    end

    render :show # render the show template for now
  end

  private

  def build_new_checklist
    checklist_type = sanitize_checklist_type(params[:checklist][:type])
    checklist_klass = checklist_type.constantize

    checklist_klass.new(owner: current_user).tap do |checklist|
      checklist.update(params_for_checklist)
    end
  end

  BASE_PARAMS = %i[
    title
    content
    status
    instance_model_name
    description
    author_name
    license
    data_entry_comments
    data_entry_input_type
    data_entry_checkbox_checked_color
    data_entry_radio_primary_text
    data_entry_radio_primary_color
    data_entry_radio_secondary_text
    data_entry_radio_secondary_color
  ].freeze

  def params_for_checklist
    params.require(required_param_key).permit(*BASE_PARAMS)
  end

  def params_for_checklist_data_entry_radio_additional_states
    params
      .fetch(:checklist)
      .permit(data_entry_radio_additional_states: %i[text color])
  end

  def required_param_key
    @checklist.present? ? @checklist.class.name.parameterize.gsub('-', '_').to_sym : :checklist
  end

  ALLOWED_CHECKLIST_TYPES = %w[Checklists::Single Checklists::Concurrent].freeze

  def sanitize_checklist_type(checklist_type)
    raise "Unknown checklist type: #{checklist_type}" unless checklist_type.in?(ALLOWED_CHECKLIST_TYPES)

    checklist_type
  end

  def load_checklist
    @checklist = Checklist.find(params[:id])
    authorize @checklist
  end

  def load_view
    @view = (params[:view] || session[:view] || 'grid').to_sym
  end

  def set_session_view
    session[:view] = params[:view] if params[:view].in?(%w[grid list])
  end
end
