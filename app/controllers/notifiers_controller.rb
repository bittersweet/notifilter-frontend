class NotifiersController < ApplicationController
  before_filter :set_event_data, only: [:new, :create]

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

  # shell out to golang that compiles from stdin (template, data)
  def preview
  end

  private

  def set_event_data
    @event_names = EventData.event_names
    @event_keys = EventData.all_keys
  end

  def notifier_params
    params.require(:notifier).
      permit(
        :event_name,
        :template,
        :rules,
        :notification_type,
        :target,
      )
  end
end
