const Items = [
  {
    co_usuario: '1',
    no_nome: 'Elenice da Silva',
    no_email: 'Dessie7937@gmail.com',
    no_cpf: '01995192180',
    st_ativo: 1,
    perfis: [
      { co_perfil: 1, no_perfil: 'Proponente' },
      { co_perfil: 2, no_perfil: 'Área técnica' },
      { co_perfil: 3, no_perfil: 'Técnico de Admissibilidade' },
    ],
  },
  {
    co_usuario: '2',
    no_nome: 'Davi dos Santos',
    no_email: 'Dessie7937@gmail.com',
    no_cpf: '01234567890',
    st_ativo: 0,
    perfis: [
      { co_perfil: 1, no_perfil: 'Proponente' },
      { co_perfil: 2, no_perfil: 'Área técnica' },
      { co_perfil: 3, no_perfil: 'Técnico de Admissibilidade' },
    ],
  },
  {
    co_usuario: '3',
    no_nome: 'Elenice da Silva',
    no_email: 'Dessie7937@gmail.com',
    no_cpf: '00426453107',
    st_ativo: 1,
    perfis: [
      { co_perfil: 1, no_perfil: 'Proponente' },
      { co_perfil: 2, no_perfil: 'Área técnica' },
      { co_perfil: 3, no_perfil: 'Técnico de Admissibilidade' },
    ],
  },
  {
    co_usuario: '4',
    no_nome: 'Davi dos Santos',
    no_email: 'Dessie7937@gmail.com',
    no_cpf: '01234567890',
    st_ativo: 0,
    perfis: [
      { co_perfil: 1, no_perfil: 'Proponente' },
      { co_perfil: 2, no_perfil: 'Área técnica' },
      { co_perfil: 3, no_perfil: 'Técnico de Admissibilidade' },
    ],
  },
  {
    co_usuario: '5',
    no_nome: 'Elenice da Silva',
    no_email: 'Dessie7937@gmail.com',
    no_cpf: '00426453107',
    st_ativo: 1,
    perfis: [
      { co_perfil: 1, no_perfil: 'Proponente' },
      { co_perfil: 2, no_perfil: 'Área técnica' },
      { co_perfil: 3, no_perfil: 'Técnico de Admissibilidade' },
    ],
  },
];

const getUserById = uuid => (uuid === undefined ? Items[0] : Items.find(x => x.co_usuario === uuid));

const getUser = limit => (limit ? Items.slice(0, limit) : Items);


const buscarUsuarios = function request() {
  return new Promise((resolve) => {
    process.nextTick(() => (
      resolve({ data: Items })
    ));
  });
};

export {
  Items, getUser, getUserById, buscarUsuarios,
};
