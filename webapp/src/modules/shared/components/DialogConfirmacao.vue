<template>
  <v-dialog
    v-model="dialog"
    v-bind="$attrs"
    persistent
    max-width="300"
  >
    <v-card>
      <v-card-title class="headline">
        {{ title }}
      </v-card-title>
      <v-card-text v-text="text" />
      <v-card-actions>
        <v-spacer />
        <v-btn
          color="green darken-1"
          text
          @click="response(false)"
        >
          {{ cancelText }}
        </v-btn>
        <v-btn
          color="green darken-1"
          text
          @click="response(true)"
        >
          {{ confirmText }}
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  name: 'DialogConfirmacao',
  props: {
    value: {
      type: Boolean,
      default: false,
    },
    title: {
      type: String,
      default: 'Tem certeza?',
    },
    text: {
      type: String,
      default: '',
    },
    cancelText: {
      type: String,
      default: 'Cancelar',
    },
    confirmText: {
      type: String,
      default: 'Tenho certeza',
    },
  },
  data() {
    return {
      dialog: false,
    };
  },
  watch: {
    value(val) {
      this.dialog = val;
    },
    dialog(val) {
      this.$emit('input', val);
    },
  },
  methods: {
    response(v) {
      this.dialog = false;
      this.$emit('dialog-response', v);
    },
  },
};
</script>
