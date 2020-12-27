class Appliance
  @@appliances = {}
  @@on = false

  attr_reader :floor_number, :energy_consuption, :type, :location
  attr_accessor :on

  def initialize(args)
    @id                = args[:id]
    @type              = args[:type]
    @energy_consuption = args[:energy_consuption]
    @floor_number      = args[:floor_number]
    @location          = args[:location]
    @number            = args[:number]
    @on                = args[:on]
  end

  def self.update(message)
    perform_operation(message)
  end

  def self.perform_operation(message)
    target_floor, target_corridor, target_sub = message[:id].split('_')

    appliance_id = "#{message[:id]}_#{message[:type]}"

    if(message[:type] == 'light')
      @@appliances[appliance_id].on = message[:command] == 'on'
    elsif(message[:type] == 'ac' && message[:command] == 'off')
      subs_acs_on = @@appliances.values.select { |app|
        app.floor_number.to_s == target_floor && app.location == 'sub' && app.on == true && app.type == 'ac'
      }

      target_applience = subs_acs_on.sample
      target_applience.on = false
    elsif(message[:type] == 'ac' && message[:command] == 'on')
      subs_acs_off = @@appliances.values.select { |app|
        app.floor_number.to_s  == target_floor && app.location == 'sub' && app.on == false && app.type == 'ac'
      }

      target_applience = subs_acs_off.sample
      target_applience.on = true if message[:energy_balance] >= target_applience.energy_consuption
    end
  end

  def self.all
    @@appliances
  end

  def self.turn_on(building)
    @@building  = building
    factory(@@building.appliances_config) unless @@on
  end

  def self.factory(appliances_config)
      appliances_config.each do |app|
        type              = app[:type]
        energy_consuption = app[:energy_consuption]
        create_main       = app[:location] == 'main'
        create_sub        = app[:location] == 'sub'

        @@building.floors_config.each do |floor|
          floor_number = floor[:number]

          floor[:main_corridors].each do |main|
            main_number = main[:number]
            self.create(type, energy_consuption, 'main', true, floor_number, main_number) if create_main

            main[:sub_corridors].each do |sub|
              on = type == 'ac' ? true : false
              self.create(type, energy_consuption, 'sub' , on, floor_number, main_number, sub[:number]) if create_sub
            end
          end
        end
      end
  end

  def self.create(type, energy_consuption, location, on, floor_number, main_number, sub_number=0)
    id = "#{floor_number}_#{main_number}_#{sub_number}_#{type}"

    @@appliances[id] = Appliance.new({
      id: id,
      type: type,
      on: on,
      floor_number: floor_number,
      number: location == 'main' ? main_number : sub_number,
      location: location,
      energy_consuption: energy_consuption
    })
  end

  def self.energy_report
    floors_array  = (1..@@building.floors_config.length).to_a
    report_hash   = Hash.new {0}
    apps          = @@appliances.values

    floors_array.each do |floor|
      saving_mode   = apps.select {|app| app.floor_number == floor && app.type == 'ac' && app.on == false}.length != 0
      current_usage = apps.select {|app| app.floor_number == floor && app.on}.map(&:energy_consuption).reduce(:+)
      report_hash[floor.to_s] = {current_usage: current_usage, saving_mode: saving_mode}
    end

    report_hash
  end

  def self.find(type, floor_number, corridor_number, sub_number=0)
    @@appliances["#{floor_number}_#{corridor_number}_#{sub_number}_#{type.downcase}"]
  end

end
