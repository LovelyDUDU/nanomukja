CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     'AKIAJKV4IKSXOPDUU6ZA',                        # required
    aws_secret_access_key: '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',                        # required
    region:                'ap-northeast-2',             # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'eatingtogether'            # required
end