require 'byebug'

Dir["./config/*.rb"].each {|file| require file }
Dir["./app/models/*.rb"].each {|file| require file }
Dir["./app/controllers/*.rb"].each {|file| require file }
Dir["./app/views/*.rb"].each {|file| require file }

building_args =
  {
    category: 'hotel',
    floors_config:      FLOORS_CONFIG,
    appliances_config:  APPLIANCES_CONFIG,
    restriction:        RESTRICTION
  }

building = Building.new(building_args)
view     = OperationsView.new(building, Appliance)

valid_controllers_args =
  {
    building:   building,
    view:       view,
    sensor:     Sensor,
    appliance:  Appliance
  }

oc = OperationsController.new(valid_controllers_args)
oc.turn_on


puts "-----------------------------------------------"
puts "                    WELCOME                    "
puts "   THIS IS THE CURRENT STATE OF THE SYSTEM     "
puts "==============================================="
puts ""
oc.print_state
oc.inputs_runner
