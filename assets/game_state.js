// Game state
const state = {
  turn: 0,
  players: [{
    name: 'Jaime',
    email: 'jaime@gmail.com', // Puede ser otro identificador (necesario para solicitudes de amistad)
    picture: 'sdffd', // La que devuelva google al iniciar sesión
    coins: 10
  }, 
  {
    name: 'Javier',
    email: 'javier@gmail.com',
    picture: 'sfsff',
    coins: 20
  }, 
  {
    name: 'Jorge',
    email: 'jorge@gmail.com',
    picture: 'sfdsfd',
    coins: 30
  }, {
    name: 'Job',
    email: 'job@gmail.com',
    picture: 'sfddsff',
    coins: 40
  }],
  map: {
    A: {
      name: 'Alicante',
      player: 0,
      troops: 3,
      factories: 0,
    },
    AB: {
      name: 'Albacete',
      player: 1,
      troops: 2,
      factories: 1,
    },
    AL: {
      name: 'Alentejo - Algarve',
      player: 2,
      troops: 3,
      factories: 0,
    },
    AM: {
      name: 'Almería',
      player: 3,
      troops: 3,
      factories: 1,
    },
    AS: {
      name: 'Ávila - Segovia',
      player: 0,
      troops: 3,
      factories: 1,
    },
    BA: {
      name: 'Badajoz',
      player: 1,
      troops: 3,
      factories: 0,
    },
    BG: {
      name: 'Barcelona - Gerona',
      player: 2,
      troops: 4,
      factories: 1,
    },
    BU: {
      name: 'Burgos',
      player: 3,
      troops: 3,
      factories: 0,
    },
    C: {
      name: 'La Coruña',
      player: 0,
      troops: 3,
      factories: 1,
    },
    CC: {
      name: 'Cáceres',
      player: 1,
      troops: 3,
      factories: 0,
    },
    CO: {
      name: 'Córdoba',
      player: 2,
      troops: 3,
      factories: 0,
    },
    CR: {
      name: 'Ciudad Real',
      player: 3,
      troops: 3,
      factories: 0,
    },
    CS: {
      name: 'Castellón',
      player: 0,
      troops: 3,
      factories: 0,
    },
    CU: {
      name: 'Cuenca',
      player: 1,
      troops: 3,
      factories: 0,
    },
    GR: {
      name: 'Granada',
      player: 2,
      troops: 3,
      factories: 0,
    },
    GU: {
      name: 'Guadalajara',
      player: 3,
      troops: 3,
      factories: 0,
    },
    H: {
      name: 'Huelva',
      player: 0,
      troops: 3,
      factories: 0,
    },
    HU: {
      name: 'Huesca',
      player: 1,
      troops: 3,
      factories: 0,
    },
    J: {
      name: 'Jaén',
      player: 2,
      troops: 3,
      factories: 1,
    },
    L: {
      name: 'Lérida',
      player: 3,
      troops: 2,
      factories: 0,
    },
    LE: {
      name: 'León',
      player: 0,
      troops: 3,
      factories: 0,
    },
    LN: {
      name: 'La Rioja - Navarra',
      player: 1,
      troops: 3,
      factories: 1,
    },
    LU: {
      name: 'Lugo',
      player: 2,
      troops: 1,
      factories: 0,
    },
    M: {
      name: 'Madrid',
      player: 3,
      troops: 3,
      factories: 1,
    },
    MC: {
      name: 'Málaga - Cádiz',
      player: 0,
      troops: 3,
      factories: 0,
    },
    MU: {
      name: 'Murcia',
      player: 1,
      troops: 3,
      factories: 0,
    },
    O: {
      name: 'Asturias',
      player: 2,
      troops: 3,
      factories: 0,
    },
    PC: {
      name: 'Portugal Centro',
      player: 3,
      troops: 3,
      factories: 0,
    },
    PN: {
      name: 'Portugal Norte',
      player: 0,
      troops: 3,
      factories: 0,
    },
    PO: {
      name: 'Pontevedra - Orense',
      player: 1,
      troops: 3,
      factories: 0,
    },
    PV: {
      name: 'País Vasco',
      player: 2,
      troops: 3,
      factories: 1,
    },
    S: {
      name: 'Cantabria',
      player: 3,
      troops: 3,
      factories: 0,
    },
    SA: {
      name: 'Salamanca',
      player: 0,
      troops: 3,
      factories: 0,
    },
    SE: {
      name: 'Sevilla',
      player: 1,
      troops: 3,
      factories: 0,
    },
    SO: {
      name: 'Soria',
      player: 2,
      troops: 3,
      factories: 0,
    },
    T: {
      name: 'Tarragona',
      player: 3,
      troops: 3,
      factories: 1,
    },
    TE: {
      name: 'Teruel',
      player: 0,
      troops: 3,
      factories: 0,
    },
    TO: {
      name: 'Toledo',
      player: 1,
      troops: 3,
      factories: 0,
    },
    V: {
      name: 'Valencia',
      player: 2,
      troops: 3,
      factories: 0,
    },
    VP: {
      name: 'Valladolid - Palencia',
      player: 3,
      troops: 3,
      factories: 0,
    },
    Z: {
      name: 'Zaragoza',
      player: 0,
      troops: 2,
      factories: 1,
    },
    ZA: {
      name: 'Zamora',
      player: 1,
      troops: 3,
      factories: 0,
    },
  },
};