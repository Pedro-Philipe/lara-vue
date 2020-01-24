import { DefaultLayout } from '@/core/components/layouts';
import RoutersConta from '@/modules/conta/router';
import RoutersShared from '@/modules/shared/router';

export default [
  ...RoutersConta,
  ...RoutersShared,
];
