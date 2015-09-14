json.array!(@boss_configs) do |boss_config|
  json.extract! boss_config, :id, :db_state, :org_name
  json.url boss_config_url(boss_config, format: :json)
end
