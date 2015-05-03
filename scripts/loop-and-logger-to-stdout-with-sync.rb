require 'logger'

STDOUT.sync = true
logger = Logger.new(STDOUT)

while true
  logger.info Time.now
  sleep 10
end
