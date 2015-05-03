unless script_path = ARGV.shift
  puts "Usage: #{__FILE__} <path-to-script>"
  exit 1
end

require 'erb'

current_directory       = File.expand_path('../', __FILE__)
template_path           = File.expand_path('../launchctl-ruby.plist.erb', __FILE__)
launch_agents_path      = File.expand_path('~/Library/LaunchAgents/')
launch_agent_name       = 'launchctl-ruby-test'
launch_agent_plist_path = File.join(launch_agents_path, "#{launch_agent_name}.plist")
plist_output_path       = File.expand_path("../tmp/#{launch_agent_name}.plist", __FILE__)
script_name             = File.basename(script_path, '.rb')
log_directory           = 'logs'
stderr_path             = "#{log_directory}/stderr.log"
stdout_path             = "#{log_directory}/stdout.log"

template = File.read(template_path)
plist    = ERB.new(template).result(binding)
File.open(plist_output_path, 'w') do |file|
  file.puts(plist)
end

# Clear old log files
`rm #{log_directory}/*.log`

# Stop and remove existing launch agent
`launchctl unload #{launch_agent_plist_path}`
`rm #{launch_agent_plist_path}`

# Copy and start new launch agent
`ln -s #{plist_output_path} #{launch_agent_plist_path}`
`launchctl load #{launch_agent_plist_path}`

puts "Plist copied and loaded"
puts "Follow the logs with:"
puts "tail -f #{stderr_path}"
puts "tail -f #{stdout_path}"
