Enjoy.configure do |config|
  config.ability_manager_config ||= []
  config.ability_manager_config << {
    method: :can,
    model: Enjoy::Goto::Transfer,
    actions: [:read]
  }

  config.ability_admin_config ||= []
  config.ability_admin_config << {
    method: :can,
    model: Enjoy::Goto::Transfer,
    actions: :manage
  }
end

Enjoy.rails_admin_configure do |config|
  if defined?(RailsAdminComments)
    config.action_visible_for :comments, 'Enjoy::Goto::Transfer'
    config.action_visible_for :model_comments, 'Enjoy::Goto::Transfer'
  end
end
