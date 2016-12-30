module MyLogger
  def self.log(msg)
    @@log ||= File.open("D:/log.txt", "a")
    @@log.puts(msg)
    @@log.flush
  end
end