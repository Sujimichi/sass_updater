class Processor

  attr_accessor :data, :updated

  def initialize *args
    @data = [args].flatten
  end
  
  def update_sass &block
    @block = block
    @count = 0
    @updated = @data.map do |line|
      update_line line
    end
  end

  def update_line line
    return line unless line.lstrip.match(/^:/)  #ignore all lines which don't have : as the first non-whitespace char
    white_space, command = line.split(":", 2)   #separate the preceeding whitespace from the rest of the command (removes the leading :)
    attribute, value = command.split(" ", 2)    #split the command into the attribute and it's value    
    new_line = "#{white_space}#{attribute}:#{value.nil? ? '' : ' ' + value}" #reconstruct with the : in the correct place
    @block.call(@count, line, new_line) if @block
    @count+=1 if @count


    new_line
  end
    
end 
