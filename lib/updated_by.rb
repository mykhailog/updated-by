require "active_record"
require "updated_by/updated"

if defined?(ActiveRecord::Base)
  require "adapters/active_record"
  ActiveRecord::Base.send :include, UpdatedBy::Updated
end

module SetCurrentUser
  private

  def set_current_user
    User.current_user = current_user if defined?(current_user) rescue nil
  end
end

ActiveSupport.on_load(:action_controller) do
  include SetCurrentUser

  before_filter :set_current_user 
end
