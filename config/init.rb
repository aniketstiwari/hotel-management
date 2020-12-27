FLOORS_CONFIG =
  [
    {
      number: 1,
      main_corridors: [{
          number: 1,
          sub_corridors: [{number:1},{number:2}]
        }]
    },
    {
      number: 2,
      main_corridors: [{
          number: 1,
          sub_corridors: [{number:1},{number:2}]
        }]
    },
  ]

APPLIANCES_CONFIG = [
      {
        type: 'ac',
        location: 'main',
        qty_per_location: 1,
        energy_consuption: 10
      },
      {
        type: 'ac',
        location: 'sub',
        qty_per_location: 1,
        energy_consuption: 10
      },
      {
        type: 'light',
        location: 'main',
        qty_per_location: 1,
        energy_consuption: 5
      },
      {
        type: 'light',
        location: 'sub',
        qty_per_location: 1,
        energy_consuption: 5
      },
    ]

RESTRICTION = {
    level: 'floor',
    main_times: 10 ,
    sub_times: 15,
    main_lights_always_on: true,
    sub_lights_always_on: false,
  }
