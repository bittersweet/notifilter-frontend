class Notifier < ActiveRecord::Base
  validates :event_name, presence: true
  validates :template, presence: true
  validates :notification_type, presence: true
  validates :target, presence: true

  def to_json
    {
      id: id,
      application: application,
      eventName: event_name,
      target: target,
      template: template,
      rules: rules
    }.to_json
  end
end
