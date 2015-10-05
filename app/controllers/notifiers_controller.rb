class NotifiersController < ApplicationController
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
      redirect_to :index, notice: "Notifier saved succesfully"
    else
      render :new
    end
  end

  private

  def notifier_params
    params.require(:notifier).
      permit(
        :notification_type,
        :event_name,
        :template,
        :rules
      )
  end
end
