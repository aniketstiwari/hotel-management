require_relative 'spec_helper'

building_args =
  {
    category: 'hotel',
    floors_config: FLOORS_CONFIG,
    appliances_config: APPLIANCES_CONFIG,
    restriction: RESTRICTION
  }

building = Building.new(building_args)
view     = OperationsView.new(building, Appliance)

valid_args =
  {
    building: building,
    sensor: Sensor,
    appliance: Appliance,
    view: view
  }

oc = OperationsController.new(valid_args)
oc.turn_on

oc.print_state
Sensor.arm(1,1,2)
oc.print_state
Sensor.arm(1,1,1)
oc.print_state
Sensor.disarm(1,1,1)
oc.print_state

p Appliance.energy_report
