Rails.application.config.middleware.use OmniAuth::Builder do
  provider :azure_activedirectoryb2c, 'a7337f0a-b1e9-471b-8ada-2784b9513854', 'tenantazureb2c.onmicrosoft.com', 'b2c_1_sign_in', 'openid'
end
