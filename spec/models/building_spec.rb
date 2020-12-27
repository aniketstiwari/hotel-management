require_relative "../spec_helper"

describe Building do
  let(:faulty_floors_config_args){
    {
      category: 'hotel',
      floors_config: [{},{}],
      appliances_config: APPLIANCES_CONFIG,
      restriction: RESTRICTION
    }
  }

  let(:faulty_appliance_config_args){
    {
      category: 'hotel',
      floors_config: FLOORS_CONFIG,
      appliances_config: [],
      restriction: RESTRICTION
    }
  }

  let(:faulty_args){
    {
      category: 'hotel'
    }
  }

  before :all do
    building_args =
      {
        category: 'hotel',
        floors_config: FLOORS_CONFIG,
        appliances_config: APPLIANCES_CONFIG,
        restriction: RESTRICTION
      }

    @building = Building.new(building_args)
  end

  context "#initialize" do
    it "created a Building object" do
     expect(@building).to be_an_instance_of Building
    end

    it "faulty floors args raise error" do
      expect{Building.new(faulty_floors_config_args)}.to raise_error(ArgumentError)
    end

    it "faulty appliance args raise error" do
      expect{Building.new(faulty_floors_config_args)}.to raise_error(ArgumentError)
    end

    it "faulty appliance args raise error" do
      expect{Building.new(faulty_floors_config_args)}.to raise_error(ArgumentError)
    end

    it "faulty args raise error" do
      expect{Building.new(faulty_args)}.to raise_error(ArgumentError)
    end
  end

  context "#restrictions" do
    it "returns a hash" do
      expect(@building.restrictions).to be_an_instance_of Hash
    end

    it "returns an expected calculation result" do
      expect(@building.restrictions['1']).to eq(40)
    end
  end
end
