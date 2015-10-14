class Notifier < ActiveRecord::Base
  validates :event_name, presence: true
  validates :template, presence: true
  validates :notification_type, presence: true
  validates :target, presence: true
end
