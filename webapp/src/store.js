import Vue from 'vue';
import Vuex from 'vuex';

import app from '@/core/store/app/';
import conta from '@/modules/conta/store/';
import localidade from '@/modules/localidade/store/';
import pessoa from '@/modules/pessoa/store/';
import shared from '@/modules/shared/store/';

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    app,
    conta,
    localidade,
    pessoa,
    shared,
  },
  getters: {
    route: state => state.route,
  },
  strict: process.env.NODE_ENV !== 'production',
});
