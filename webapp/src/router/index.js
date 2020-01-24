import Vue from 'vue';
import Router from 'vue-router';
import NProgress from 'nprogress';
import appRoutes from './config';
import 'nprogress/nprogress.css';
import coreRoutes from '@/core/router';
import { obterInformacoesJWT } from '@/modules/shared/service/helpers/jwt';
import { eventHub } from '@/event';

const routes = coreRoutes.concat(appRoutes);

Vue.use(Router);

const router = new Router({
  mode: 'history',
  linkActiveClass: 'active',
  routes,
});

const emitirMensagemErro = (mensagem) => {
  eventHub.$nextTick(() => {
    eventHub.$emit('eventoErro', mensagem);
  });
};

const isEmpty = string => (!string || string.length === 0);

router.beforeEach((to, from, next) => {
  NProgress.start();

  const authRequired = !to.meta.public || to.meta.public === false;
  const userToken = localStorage.getItem('user_token');
  const tokenValida = !isEmpty(obterInformacoesJWT(userToken));
  try {
    if (!userToken && authRequired && to.path !== '/conta/autenticar') {
      throw new Error('Acesso negado!');
    }

    if (userToken && authRequired && !tokenValida) {
      localStorage.removeItem('user_token');
      throw new Error('Seu acesso expirou!');
    }
    return next();
  } catch (objEx) {
    emitirMensagemErro(objEx.message);
    return next('/conta/autenticar');
  }
});

router.afterEach(() => {
  NProgress.done();
});

export default router;
