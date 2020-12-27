require_relative "../spec_helper"

describe OperationsController do
  before :all do
    building_args =
      {
        category: 'hotel',
        floors_config: FLOORS_CONFIG,
        appliances_config: APPLIANCES_CONFIG,
        restriction: RESTRICTION
      }

    @building = Building.new(building_args)

    valid_args =
      {
        building: @building,
        sensor: Sensor,
        appliance: Appliance
      }

    @operations_controller = OperationsController.new(valid_args)
  end

  context "#initialize" do
    it "creates a OperationsController object" do
      expect(@operations_controller).to be_an_instance_of OperationsController
    end
  end

  context "#on" do
    it "should start as false" do
      expect(@operations_controller.on).to be false
    end
  end

end
