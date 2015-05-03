require 'logger'

logger = Logger.new('logs/logger.log')

while true
  logger.info Time.now
  sleep 10
end
