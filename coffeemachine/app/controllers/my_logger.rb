module MyLogger
  def self.log(msg)
    @@log ||= File.open("log.txt", "a")
    @@log.puts(msg)
  end
end