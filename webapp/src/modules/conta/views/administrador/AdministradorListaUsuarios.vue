<template>
  <div class="list-table">
    <v-container
      grid-list-xl
      fluid
    >
      <v-row
        row
        wrap
      >
        <v-col lg="12">
          <v-card>
            <v-card-title>
              <v-btn
                tiny
                round
                outline
                color="indigo"
                @click="editarItemModal()">
                <v-icon>add</v-icon>
                Usuario
              </v-btn>
              <v-spacer />
              <v-spacer />
              <v-text-field
                v-model="pesquisar"
                append-icon="search"
                label="Pesquisar"
                single-line
                hide-details
              />
            </v-card-title>
            <v-card-text class="pa-0">
              <v-data-table
                :headers="headers"
                :items="usuariosGetter"
                :pagination.sync="pagination"
                :total-items="totalItems"
                :loading="loading"
                :search="pesquisar"
                item-key="co_usuario"
                class="elevation-1"
              >
                <template
                  slot="items"
                  slot-scope="props"
                >
                  <td>{{ props.item.nu_cpf_formatado }}</td>
                  <td>{{ props.item.no_nome }}</td>
                  <td>
                    <v-chip>
                      {{ props.item.perfil.ds_perfil }}
                    </v-chip>
                  </td>
                  <td>
                    <v-chip
                      :color="props.item.st_ativo ? 'green' : 'red'"
                      text-color="white"
                    >
                      {{ props.item.situacao }}
                    </v-chip>
                  </td>
                  <td>
                    <v-btn
                      depressed
                      outline
                      icon
                      fab
                      dark
                      color="primary"
                      small
                      @click="editarItemModal(props.item)"
                    >
                      <v-icon>edit</v-icon>
                    </v-btn>
                  </td>
                </template>
              </v-data-table>
              <administrador-lista-usuarios-dialog
                v-model="mostrarModalEdicao"
                :usuario="itemEditado"
              />
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex';
import AdministradorListaUsuariosDialog from './AdministradorListaUsuariosDialog';

export default {
  name: 'AdministradorListaUsuarios',
  components: { AdministradorListaUsuariosDialog },
  data() {
    return {
      loading: true,
      pagination: {
        page: 1,
        rowsPerPage: 10,
      },
      pesquisar: '',
      mostrarModalEdicao: false,
      totalItems: 0,
      filtros: {},
      itemEditado: {},
      headers: [
        {
          text: 'CPF',
          value: 'nu_cpf_formatado',
        },
        {
          text: 'Nome',
          value: 'no_nome',
        },
        {
          text: 'Perfil',
          value: 'perfil.ds_perfil',
          sortable: false,
        },
        {
          text: 'Status',
          value: 'situacao',
        },
        {
          text: 'Ações',
          sortable: false,
        },
      ],
    };
  },
  computed: {
    ...mapGetters({
      usuariosGetter: 'conta/usuarios',
    }),
  },
  methods: {
    ...mapActions({
      buscarUsuariosPerfis: 'conta/buscarUsuariosPerfis',
    }),
    editarItemModal(item) {
      this.itemEditado = item;
      this.mostrarModalEdicao = true;
    },
  },
  watch: {
  },
  mounted() {
    const self = this;
    self.loading = true;
    self.buscarUsuariosPerfis().finally(() => {
      self.loading = false;
    });
  },
};
</script>
