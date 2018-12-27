require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

ENV['ALIPAY_PID'] = 'YOUR-ALIPAY-PARTNER-ID'
ENV['ALIPAY_MD5_SECRET'] = 'YOUR-ALIPAY-MD5-SECRET'
ENV['ALIPAY_URL'] = 'https://mapi.alipay.com/gateway.do'
ENV['ALIPAY_RETURN_URL'] = 'http://localhost:3000/payments/pay_return'
ENV['ALIPAY_NOTIFY_URL'] = 'http://localhost:3000/payments/pay_notify'

ENV['WECHAT_DEV_SANDBOX_ID'] = 'gh_030ad66dea98'
ENV['WECHAT_DEV_SANDBOX_APP_ID'] = 'wxc9e21579278a899b'
ENV['WECHAT_DEV_SANDBOX_APP_SECRET'] = '5aeff47ab1f731c96d058ff13df28e10'
ENV['WECHAT_DEV_SANDBOX_PUSH_TOKEN'] = 'ldqt'


module MasterRailsByActions
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.autoload_paths += %W[#{Rails.root}/lib]

    config.generators do |generator|
      generator.assets false
      generator.test_framework false
      generator.skip_routes true
    end

  end
end
