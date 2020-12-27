require_relative "../spec_helper"

describe 'Appliance' do

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

    @soperations_controller = OperationsController.new(valid_args)
  end

  context ".turn_on" do
    before do
      Appliance.turn_on(@building)
    end

    it "initialize instances of it self" do
      expect(Appliance.all[Appliance.all.keys.sample]).to be_an_instance_of Appliance
    end

    it "@@appliances hash of Appliance instances as values" do
      expect(Appliance.all.values.map(&:class).uniq.pop).to eq Appliance
    end
  end

  context ".find" do
    it "finds an instance of Apliance in collection" do
      expect(Appliance.find('light', 1, 1, 1)).to be_an_instance_of Appliance
    end
  end

  context ".energy_report" do
    it "its a Hash" do
      expect(Appliance.energy_report).to be_an_instance_of Hash
    end
  end
end
