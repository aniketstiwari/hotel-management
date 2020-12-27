require "observer"
class Sensor
  include Observable

  @@controller  = nil
  @@sensors     = {}
  @@turned_on   = false

  attr_reader :id, :armed, :floor_number, :location

  def initialize(args)
    @id           = args[:id]
    @floor_number = args[:floor_number]
    @location     = args[:location]
    @armed        = false
    add_observer(@@controller)
  end

  def armed=(armed_update)
    changed
    @armed = armed_update
    notify_observers(self)
  end

  def self.turn_on(building, controller)
    unless(building.class == Building && controller.class == OperationsController)
      raise(ArgumentError, "Please make sure that your are instatiating this class with instances of the appropiate classes.")
    end

    @@building   = building
    @@controller = controller
    factory unless @@turned_on
    @@turned_on   = true
  end

  def self.factory
    @@building.floors_config.each do |floor|
      floor_number = floor[:number]

      floor[:main_corridors].each do |main|
        main_number = main[:number]
        self.create('main', floor_number, main_number)

        main[:sub_corridors].each do |sub|
          self.create('sub', floor_number, main_number, sub[:number])
        end
      end
    end
  end

  def self.create(location, floor_number, main_number, sub_number=0)
    id = "#{floor_number}_#{main_number}_#{sub_number}"
    @@sensors[id] = Sensor.new({
      id: id, floor_number: floor_number, location: location
      })
  end

  def self.all
    @@sensors
  end

  def self.arm(floor_number, corridor_number, sub_number=0)
    find_update_armed(true, floor_number, corridor_number, sub_number)
  end

  def self.disarm(floor_number, corridor_number, sub_number=0)
    find_update_armed(false, floor_number, corridor_number, sub_number)
  end

  def self.find_update_armed(arm_value, floor_number, corridor_number, sub_number=0)
    target_sensor = @@sensors["#{floor_number}_#{corridor_number}_#{sub_number}"]

    if (target_sensor == nil)
      raise(ArgumentError, "Sensor not found, please check floor, corridor and sub corridor data.")
    else
      target_sensor.armed = arm_value
    end
  end
end
