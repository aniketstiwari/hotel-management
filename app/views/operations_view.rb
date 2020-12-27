require "observer"

class OperationsView

  def initialize(building, appliance)
    @building = building
    @appliance = appliance
  end

  def print_state
    appliances = @appliance.all

    puts "------------------"
    puts "State Report"
    puts "------------------"
    @building.floors_config.each do |floor|
      puts "Floor #{floor[:number]}"

      floor[:main_corridors].each do |main|
        puts "  Main corridor #{main[:number]}"
        puts "  Light: #{appliances["#{floor[:number]}_#{main[:number]}_0_light"].on ? 'ON' : 'OFF'}"
        puts "  AC: #{appliances["#{floor[:number]}_#{main[:number]}_0_ac"].on ? 'ON' : 'OFF'}"

        main[:sub_corridors].each do |sub|
          puts "    Sub corridor #{sub[:number]}"
          puts "      Light: #{appliances["#{floor[:number]}_#{main[:number]}_#{sub[:number]}_light"].on ? 'ON' : 'OFF'}"
          puts "      AC: #{appliances["#{floor[:number]}_#{main[:number]}_#{sub[:number]}_ac"].on ? 'ON' : 'OFF'}"
        end
      end
    end
    puts "------------------"
  end
end
