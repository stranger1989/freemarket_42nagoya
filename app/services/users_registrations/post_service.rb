module UsersRegistrations
  module PostService
    # include Devise::Controllers::Helpers
    def self.update_creditcard!(account_update_params, params)
      if params[:"payjp-token"].present?
        Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
        customer = Payjp::Customer.create(
          :card  => params['payjp-token']
        )
        update_payjp(account_update_params, { payment: customer[:id] })
      end
      return account_update_params
    end

    def self.update_success_or_fail!(resource, account_update_params)
      resource.update_without_current_password(account_update_params).present?
        # yield resource if block_given?
        # if is_flashing_format?
        #   flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
        #     :update_needs_confirmation : :updated
        #   set_flash_message :notice, flash_key
        # end
    end

    protected

    def update_resource(resource, params)
      resource.update_without_current_password(params)
    end

    def update_payjp(account_update_params, payjp_params={})
      account_update_params = account_update_params.merge(payjp_params)
      return account_update_params
    end
  end
end
