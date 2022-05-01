
current_dir = File.absolute_path( File.dirname(__FILE__) )
cookbook_path ["#{current_dir}/cookbooks"]
node_path     "#{current_dir}/nodes"
role_path     "#{current_dir}/roles"
ssl_verify_mode :verify_peer
