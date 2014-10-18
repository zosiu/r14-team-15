module ApplicationHelper
  BOOTSTRAP_FLASH_MSG = { success: 'alert-success',
                          error: 'alert-danger',
                          alert: 'alert-danger',
                          notice: 'alert-info' }

  def bootstrap_class_for(flash_type)
    BOOTSTRAP_FLASH_MSG.fetch flash_type.to_sym, flash_type.to_s
  end

  def flash_messages
    flash.each do |msg_type, message|
      klass = "alert #{bootstrap_class_for(msg_type)} alert-dismissable"
      haml_tag :div, class: klass do
        haml_tag :span, message
        haml_tag :button, 'x', class: 'close', data: { dismiss: 'alert' }
      end
    end
    nil
  end

  def destroy_link_to(path)
    link_to 'Destroy', path, method: :delete,
                             class: 'btn btn-sm btn-danger',
                             'data-confirm' => 'Are you sure?',
                             'data-confirm-fade' => true,
                             'data-confirm-title' => 'Destroy',
                             'data-confirm-cancel' => 'cancel',
                             'data-confirm-cancel-class' => 'btn-default',
                             'data-confirm-proceed' => 'ok',
                             'data-confirm-proceed-class' => 'btn-danger'
  end

  def user_resource_name
    :user
  end

  def user_resource
    @resource ||= User.new
  end

  def user_devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def action?(*action)
    action.include?(params[:action])
  end
end
