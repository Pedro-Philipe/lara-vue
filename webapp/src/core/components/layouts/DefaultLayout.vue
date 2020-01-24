<template>
  <v-container
    fluid
    no-gutter
  >
    <app-drawer
      class="app--drawer"
    />
    <app-toolbar
      class="app--toolbar"
    />
    <v-content>
      <page-header />

      <!-- content -->
      <div class="page-wrapper">
        <router-view />
      </div>
    </v-content>
    <!-- Go to top -->
    <app-fab />

    <!-- App Footer -->
    <v-footer
      app
      inset
      absolute
    >
      <span class="caption">Compra institucional {{ new Date().getFullYear() }}</span>
      <v-spacer />
      <span class="caption mr-1"> Ministério da Cidadania </span>
    </v-footer>
  </v-container>
</template>

<script>
import { mapActions } from 'vuex';
import AppDrawer from '@/core/components/AppDrawer';
import AppToolbar from '@/core/components/AppToolbar';
import AppFab from '@/core/components/AppFab';

export default {
  components: {
    AppDrawer,
    AppToolbar,
    AppFab,
  },
  mounted() {
    // this.setUsuarioLogadoAction();
  },
  created() {
    // this.setUsuarioLogadoAction();
    // this.setPerfilAtivoAction();
    // this.setMenuAction();
  },
  methods: {
    ...mapActions({
      // setUsuarioLogadoAction: 'app/setUsuarioLogado',
      // setPerfilAtivoAction: 'app/setPerfilAtivo',
      // setMenuAction: 'app/setMenu',
    }),
  },
};
</script>

<style scoped>
.page-wrapper {
  min-height: calc(100vh - 64px - 50px - 81px);
}
</style>
