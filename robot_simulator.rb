class Robot
    @headpointing = nil
    @coordinates = nil
    def orient(direction)
        a=%i(north south east west)
        if a.include?(direction)
         @headpointing = direction
        else
          raise ArgumentError do end 
        end
      end
  
    def turn_right
      @headpointing = case @headpointing
                      when :north
                        :east
                      when :east
                        :south
                      when :south
                        :west
                      when :west
                        :north
                      else
                        raise ArgumentError do end
                      end
    end
  
    def turn_left
      @headpointing = case @headpointing
                      when :north
                        :west
                      when :west
                        :south
                      when :south
                        :east
                      when :east
                        :north
                      else
                        raise ArgumentError do end
                      end
    end
  
    def bearing
      @headpointing
    end
  
    def at(x, y)
      arr = [x, y]
      @coordinates = arr
      arr
    end
  
    attr_reader :coordinates
  
    def advance
      case @headpointing
      when :north
        @coordinates[1] = @coordinates[1] + 1
      when :south
        @coordinates[1] = @coordinates[1] - 1
      when :east
        @coordinates[0] = @coordinates[0] + 1
      when :west
        @coordinates[0] = @coordinates[0] - 1
      end
    end
end
  
class Simulator
    attr_accessor :robo
  
    @@robo = []
  
    def instructions(mo)
      command = []
      mo = mo.split('')
      mo.each do |m|
        case m
        when 'L'
          command << :turn_left
        when 'R'
          command << :turn_right
        when 'A'
          command << :advance
        else
          raise ArgumentError do end
        end
      end
      command
    end
  
    def place(robot, x: 0, y: 0, direction: nil)
      robot.at(x, y)
      robot.orient(direction)
      @@robo << robot
    end
  
    def evaluate(robot, command)
      @@robo.each do |robo|
        next unless robo == robot
  
        commands = instructions(command)
        commands.each do |c|
          case c
          when :turn_left
            robo.turn_left
          when :turn_right
            robo.turn_right
          when :advance
            robo.advance
          end
        end
        robo.coordinates
        robo.bearing
      end
      def clear_list
        @@robo = []
      end
    end
end