<template>
  <v-card>
    <v-toolbar
      flat
      dense
      color="transparent"
    >
      <v-toolbar-title class="font-weight-light">
        Message
      </v-toolbar-title>
    </v-toolbar>
    <v-divider />
    <v-card-text class="pa-0">
      <v-list
        two-line
        class="pa-0"
      >
        <template v-for="(item, index) in items">
          <v-subheader
            v-if="item.header"
            :key="item.header"
          >
            {{ item.header }}
          </v-subheader>
          <v-divider
            v-else-if="item.divider"
            :key="index"
          />
          <v-list-item
            v-else
            :key="item.title"
            avatar
            @click="handleClick"
          >
            <v-list-item-avatar>
              <img :src="item.avatar">
            </v-list-item-avatar>
            <v-list-item-content>
              <v-list-item-title v-text="item.title" />
              <v-list-item-subtitle v-text="item.subtitle" />
            </v-list-item-content>
          </v-list-item>
        </template>
      </v-list>
      <v-divider />
      <v-btn
        block
        text
        class="ma-0"
      >
        All
      </v-btn>
      <v-divider />
    </v-card-text>
  </v-card>
</template>
<script>
import messages from '../../../api/message';

export default {
  data: () => ({
    items: messages,
  }),
  methods: {
    handleClick: () => {},
  },
};
</script>
