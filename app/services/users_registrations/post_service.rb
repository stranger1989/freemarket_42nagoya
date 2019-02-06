module UsersRegistrations
  module PostService
    def self.update_creditcard!(account_update_params, params)
      if params[:"payjp-token"].present?
        Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
        customer = Payjp::Customer.create(
          :card  => params['payjp-token']
        )
        account_update_params = account_update_params.merge({ payment: customer[:id] })
      end
      return account_update_params
    end

    def self.update_success_or_fail!(resource, account_update_params)
      resource.update_without_current_password(account_update_params).present?
    end
  end
end
