I wondered why I wasn't always seeing output (on stdout and stderr) when using the StandardOutPath and StandardErrorPath plist directives respectively.

These scripts show that it's caused by output buffering in Ruby. `STDOUT.sync` is set to `false` by default so Ruby will buffer the output until some unknowable (I think) time. I can avoid this by using Ruby's `Logger` with a file, or by setting `STDOUT.sync = true`.

Use `ruby setup.rb scripts/<name-of-script>.rb` to install a Launch Agent plist and then observe how the logfiles in logs/ change.

## Results

### loop-and-logger-to-file

Logfile is updated every 10 seconds.

### loop-and-logger-to-stdout

Output is buffered for some unknown period of time. I only ever saw the logfiles written to when manually stopping the LaunchAgent.

### loop-and-logger-to-stdout-with-sync

Logfile is updated every 10 seconds.

### loop-and-print-to-stdout

Output is buffered for some unknown period of time. I only ever saw the logfiles written to when manually stopping the LaunchAgent.

### loop-and-print-to-stdout-with-sync

Logfile is updated every 10 seconds.

### print-stdout-sync-value

The result is that STDOUT.sync is false. Interestingly, this is written to the logfile immediately.
