<template>
  <v-app-bar
    color="primary"
    fixed
    dark
    text
    app
    clipped-left
  >
    <div class="toolbar-logo theme--dark primary darken-1">
      <v-app-bar-nav-icon
        class="hidden-md-and-up"
        @click="toggleMenu()"
      />
      <img
        :src="require('@/core/assets/logo.svg')"
        alt="Logo do Sistema"
      >
      <v-toolbar-title class="ml-0 pl-3 mt-2 hidden-sm-and-down">
        <span>{{ appTitle }}</span>
      </v-toolbar-title>
      <v-btn
        class="button-drawer mx-2 hidden-sm-and-down"
        fab
        dark
        small
        color="primary darken-1"
        @click="toggleMenu()"
      >
        <v-icon dark>
          {{ menuAppStatusGetter ? 'chevron_right' : 'chevron_left' }}
        </v-icon>
      </v-btn>
    </div>
    <v-toolbar-title class="ml-10">
      {{ $route.meta.title }}
    </v-toolbar-title>
    <v-spacer />
    <v-toolbar-items>
      <v-btn
        icon
        @click="handleFullScreen()"
      >
        <v-icon>fullscreen</v-icon>
      </v-btn>

      <v-menu
        v-model="menuUsuario"
        offset-y
        origin="center center"
        :nudge-bottom="10"
        transition="scale-transition"
        :close-on-content-click="false"
      >
        <template v-slot:activator="{ on }">
          <v-btn
            slot="activator"
            icon
            large
            text
            v-on="on"
          >
            <v-avatar color="primary">
              <v-icon
                medium
                dark
              >
                account_circle
              </v-icon>
            </v-avatar>
          </v-btn>
        </template>
        <v-card>
          <v-list>
            <v-list-item>
              <v-list-item-avatar>
                <v-icon medium>
                  account_circle
                </v-icon>
              </v-list-item-avatar>
              <v-list-item-content>
                <v-list-item-title>
                  teste
                  <!--{{ usuarioLogadoGetter.no_nome }}-->
                </v-list-item-title>
                <v-list-item-subtitle>
                  04752796112
                  <!--{{ usuarioLogadoGetter.no_cpf | mxFiltroFormatarCPFCNPJ }} -->
                </v-list-item-subtitle>
              </v-list-item-content>
            </v-list-item>
          </v-list>
          <v-divider />
          <v-list two-line>
            <v-list-item>
              <v-list-item-content>
                  <!--v-if="perfisGetter.length > 0"-->
                  <!--v-model="perfilAtivo"-->
                  <!--:items="perfisGetter"-->
                  <!--item-text="no_perfil"-->
                  <!--item-value="co_perfil"-->
                  <!--label="Perfil"-->
                  <!--return-object-->
                  <!--@change="handlePerfil($event)"-->
                <v-select
                />
              </v-list-item-content>
            </v-list-item>
          </v-list>
          <v-divider />
          <v-list>
            <v-list-item
              v-for="(item, index) in items"
              :key="index"
              :href="item.href"
              ripple="ripple"
              :disabled="item.disabled"
              :target="item.target"
              rel="noopener"
              @click="item.click"
            >
              <v-list-item-action v-if="item.icon">
                <v-icon>{{ item.icon }}</v-icon>
              </v-list-item-action>
              <v-list-item-content>
                <v-list-item-title>{{ item.title }}</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </v-list>
        </v-card>
      </v-menu>
    </v-toolbar-items>
  </v-app-bar>
</template>
<script>
import { mapGetters, mapActions } from 'vuex';
import NotificationList from '@/core/components/widgets/list/NotificationList';
import Util from '../util';
import MxFiltros from '@/modules/shared/mixins/filters';

export default {
  name: 'AppToolbar',
  components: {
    NotificationList,
  },

  mixins: [
    MxFiltros,
  ],

  data() {
    return {
      appTitle: process.env.VUE_APP_TITLE,
      perfilAtivo: {},
      menuUsuario: false,
      items: [
        {
          icon: 'lock',
          href: '',
          title: 'Alterar Senha',
          click: this.handleChangePassword,
        },
        {
          icon: 'settings',
          href: '',
          title: 'Tema',
          click: this.abrirConfiguracoesDoTema,
        },
        {
          icon: 'exit_to_app',
          href: '',
          title: 'Logout',
          click: this.handleLogut,
        },
      ],
    };
  },

  computed: {
    ...mapGetters({
      usuarioLogadoGetter: 'app/usuarioLogado',
      perfisGetter: 'app/perfis',
      perfilAtivoGetter: 'app/perfilAtivo',
      menuAppStatusGetter: 'app/menuAppStatus',
      secondaryDrawerGetter: 'app/secondaryDrawer',
    }),
    toolbarColor() {
      return this.$vuetify.options.extra.mainNav;
    },
  },

  mounted() {
    this.perfilAtivo = this.perfilAtivoGetter;
  },

  methods: {
    ...mapActions({
      setMenuAction: 'app/setMenu',
      setPerfilAtivoAction: 'app/setPerfilAtivo',
      setMenuAppStatusAction: 'app/setMenuAppStatus',
      toggleDrawerThemeAction: 'app/toggleDrawerTheme',
      setPrimaryDrawerStatus: 'app/setPrimaryDrawerStatus',
    }),
    handleFullScreen() {
      Util.toggleFullScreen();
    },
    handleChangePassword() {
      this.$router.push({ name: 'usuario.alterar.senha' });
    },
    handleLogut() {
      this.$router.push({ name: 'conta-sair' });
    },
    handlePerfil(perfil) {
      this.setPerfilAtivoAction(perfil);
      this.setMenuAction();
      this.$router.push('/');
    },
    abrirConfiguracoesDoTema() {
      this.menuUsuario = false;
      this.toggleDrawerThemeAction(true);
    },
    toggleMenu() {
      this.setMenuAppStatusAction(!this.menuAppStatusGetter);

      if (this.menuAppStatusGetter && !this.secondaryDrawerGetter.model) {
        this.setPrimaryDrawerStatus(this.menuAppStatusGetter);
      }
    },
  },
};
</script>

<style lang="sass" scoped>
  .toolbar-logo
    display: flex
    padding: 5px
    margin-left: -18px !important
    width: 258px
    height: 64px
    position: relative
    @media #{map-get($display-breakpoints, 'sm-and-down')}
      height: 56px
      width: 122px
      margin-left: -17px !important

    .button-drawer
      position: absolute
      top: 10px
      right: -28px
      @media #{map-get($display-breakpoints, 'sm-and-down')}
        .button-drawer
          top: 4px

  .toolbar-logo
    img
      margin: 10px 15px
      height: 36px
      @media #{map-get($display-breakpoints, 'sm-and-down')}
        height: 28px
        margin-top: 10px !important

</style>
