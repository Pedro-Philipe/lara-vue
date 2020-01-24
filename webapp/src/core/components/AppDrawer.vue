<template>
  <v-navigation-drawer
    :value="primaryDrawerGetter.model && menuAppStatusGetter"
    :clipped="primaryDrawerGetter.clipped"
    :permanent="primaryDrawerGetter.type === 'permanent'"
    :temporary="primaryDrawerGetter.type === 'temporary'"
    :floating="primaryDrawerGetter.floating"
    :mini-variant="primaryDrawerGetter.mini"
    hide-overlay
    app
    @input="toggleStatusPrimaryDrawer($event)"
  >
    <vue-perfect-scrollbar
      class="drawer-menu--scroll"
      :settings="scrollSettings"
    >
      <v-list
        dense
        expand
      >
        <template v-for="item in menusGetter">
          <!--group with subitems-->
          <v-list-group
            v-if="item.filhas.length >= 1 && item.st_menu == true"
            :key="item.no_funcionalidade"
            :value="isActive(item)"
            :prepend-icon="item.no_icone"
            no-action="no-action"
          >
            <template v-slot:activator>
              <v-list-item-content>
                <v-list-item-title>{{ item.no_funcionalidade }}</v-list-item-title>
              </v-list-item-content>
            </template>
            <template v-for="subItem in item.filhas">
              <!--sub group-->
              <v-list-group
                v-if="subItem.filhas.length >= 1 && subItem.st_menu == true"
                :key="subItem.no_funcionalidade"
                sub-group
              >
                <template v-slot:activator>
                  <v-list-item-content>
                    <v-list-item-title>{{ subItem.no_funcionalidade }}</v-list-item-title>
                  </v-list-item-content>
                </template>
                <v-list-item
                  v-for="grand in subItem.filhas"
                  :key="grand.no_funcionalidade"
                  :to="!grand.href ? {name: grand.no_rota} : null"
                  :href="grand.href"
                  link
                >
                  <v-list-item-content>
                    <v-list-item-title>{{ grand.no_funcionalidade }}</v-list-item-title>
                  </v-list-item-content>
                </v-list-item>
              </v-list-group>
              <!--child item-->
              <v-list-item
                v-else
                :key="subItem.no_funcionalidade"
                :to="!subItem.href ? {name: subItem.no_rota} : null"
                :href="subItem.href"
                :disabled="subItem.disabled"
                :target="subItem.target"
                link
              >
                <v-list-item-content>
                  <v-list-item-title>
                    <span>{{ subItem.no_funcionalidade }}</span>
                  </v-list-item-title>
                </v-list-item-content>
                <v-list-item-action v-if="subItem.action">
                  <v-icon :class="[subItem.actionClass || 'success--text']">
                    {{ subItem.action }}
                  </v-icon>
                </v-list-item-action>
              </v-list-item>
            </template>
          </v-list-group>
          <v-subheader
            v-else-if="item.header"
            :key="item.name"
            class="font-weight-bold"
          >
            {{ item.header }}
          </v-subheader>
          <v-divider
            v-else-if="item.divider"
            :key="item.name"
          />
          <!--top-level link-->
          <v-list-item
            v-else
            :key="item.no_funcionalidade"
            :to="!item.href ? { name: item.no_rota } : null"
            :href="item.href"
            :disabled="item.disabled"
            :target="item.target"
            rel="noopener"
            link
          >
            <v-list-item-action v-if="item.no_icone">
              <v-icon>{{ item.no_icone }}</v-icon>
            </v-list-item-action>
            <v-list-item-content>
              <v-list-item-title>{{ item.no_funcionalidade }}</v-list-item-title>
            </v-list-item-content>
            <v-list-item-action v-if="item.subAction">
              <v-icon class="success--text">
                {{ item.subAction }}
              </v-icon>
            </v-list-item-action>
          </v-list-item>
        </template>
      </v-list>
    </vue-perfect-scrollbar>
  </v-navigation-drawer>
</template>
<script>
import VuePerfectScrollbar from 'vue-perfect-scrollbar';
import { mapGetters, mapActions } from 'vuex';

export default {
  name: 'AppDrawer',
  components: {
    VuePerfectScrollbar,
  },

  data() {
    return {
      menus: {},
      scrollSettings: {
        maxScrollbarLength: 160,
      },
    };
  },

  computed: {
    ...mapGetters({
      usuarioLogadoGetter: 'app/usuarioLogado',
      menusGetter: 'app/menus',
      menuAppStatusGetter: 'app/menuAppStatus',
      primaryDrawerGetter: 'app/primaryDrawer',
    }),
    computeGroupActive() {
      return true;
    },
    sideToolbarColor() {
      return this.$vuetify.options.extra.sideNav;
    },
  },

  mounted() {
    if (this.$vuetify.breakpoint.mdAndDown) {
      this.setMenuAppStatus(false);
    }
  },

  methods: {
    ...mapActions({
      setPrimaryDrawerStatus: 'app/setPrimaryDrawerStatus',
      setMenuAppStatus: 'app/setMenuAppStatus',
    }),
    toggleStatusPrimaryDrawer(status) {
      this.setPrimaryDrawerStatus(status);

      if (status === false && this.$vuetify.breakpoint.mdAndDown) {
        this.setMenuAppStatus(false);
      }
    },
    isActive(item) {
      return this.$route.path.split('/')[1] === item.no_grupo;
    },
  },
};
</script>

<style lang="sass" scoped>
.app--drawer
  overflow: hidden
  .drawer-menu--scroll
    height: calc(100% - 60px)
    overflow: auto
</style>
