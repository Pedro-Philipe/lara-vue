const Menu = [
  { header: 'App' },
  {
    title: 'Home',
    name: 'Dashboard',
    icon: 'home',
  },
  // { divider: true },
  {
    title: 'Administrativo',
    name: 'Administrativo',
    group: 'conta',
    icon: 'settings',
    items: [
      {
        title: 'Perfis',
        name: 'Perfil',
        component: 'conta-perfil-listar',
      },
      {
        title: 'Usuários',
        name: 'Usuario',
        component: 'conta-usuario-listar',
      },
    ],
  },
  // { divider: true },
  {
    title: 'Proponente',
    name: 'Proponente',
    group: 'proponente',
    icon: 'person',
    items: [
      {
        title: 'Proponente',
        name: 'Proponente',
        component: 'agente.proponente.index',
      },
      {
        title: 'Gerenciar Responsável',
        name: 'Gerenciar Responsável',
        component: 'agente.responsavel.index',
      },
      {
        title: 'Solicitar Vinculo',
        name: 'Solicitar Vinculo',
        component: 'agente.responsavel.store',
      },
    ],
  },
  { divider: true },
  { header: 'Projeto' },
  {
    title: 'Projeto',
    name: 'Projeto',
    group: 'projeto',
    icon: 'layers',
    items: [
      {
        title: 'Listar projetos',
        name: 'Projetos',
        component: 'projeto.index',
      },
      {
        title: 'Cadastrar',
        name: 'Cadastrar',
        component: 'projeto.identificacao.store',
      },
    ],
  },
  // { divider: true, name: 'teste' },
];
// reorder menu
Menu.forEach((item) => {
  if (item.items) {
    item.items.sort((x, y) => {
      const textA = x.title.toUpperCase();
      const textB = y.title.toUpperCase();
      /* eslint-disable */
            return textA < textB ? -1 : textA > textB ? 1 : 0;
        });
    }
});

export default Menu;
