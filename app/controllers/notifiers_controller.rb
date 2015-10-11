class NotifiersController < ApplicationController
  before_filter :set_event_data, only: [:new, :create, :edit, :update]

  def index
    @notifiers = Notifier.all
  end

  def show
    @notifier = Notifier.find(params[:id])
  end

  def new
    @notifier = Notifier.new
  end

  def create
    @notifier = Notifier.new(notifier_params)

    if @notifier.save
      redirect_to notifiers_path, notice: "Notifier saved succesfully"
    else
      render :new
    end
  end

  def edit
    @notifier = Notifier.find(params[:id])
    @applications = EventData.applications
  end

  def update
    @notifier = Notifier.find(params[:id])
    if @notifier.update_attributes(notifier_params)
      redirect_to notifiers_path, notice: "Notifier updated succesfully"
    else
      render :edit
    end
  end

  def destroy
    @notifier = Notifier.find(params[:id])
    @notifier.destroy
    redirect_to notifiers_path, notice: "Notifier deleted succesfully"
  end

  # shell out to golang that compiles from stdin (template, data)
  def preview
  end

  private

  def set_event_data
    @event_names = EventData.event_names
    @event_keys = EventData.all_keys
    @applications = EventData.applications
  end

  def notifier_params
    params.require(:notifier).
      permit(
        :application,
        :event_name,
        :notification_type,
        :target,
        :template,
        :rules,
      )
  end
end
