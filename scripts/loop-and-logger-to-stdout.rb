require 'logger'

logger = Logger.new(STDOUT)

while true
  logger.info Time.now
  sleep 10
end
