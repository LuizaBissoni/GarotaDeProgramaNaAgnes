select
a.id_documento,
a.indretif_ideevento,
a.nrrecibo_ideevento,
a.tpamb_ideevento,
a.procemi_ideevento,
a.verproc_ideevento,
a.tpinsc_ideempregador,
a.nrinsc_ideempregador,
a.cpf_trab,
a.matricula,
a.cod_categ,
a.dt_ini_afast,
a.cod_mot_afast,
a.info_mesmo_mtv,
a.tp_acid_transito,
a.observacao,
a.dt_inicio_per_aquis,
a.dt_fim_per_aquis,
a.cnpj_cess,
a.inf_onus,
a.cnpj_sind,
a.inf_onus_remun,
a.cnpj_mand_elet_info_mand_elet,
a.ind_remun_cargo_info_mand_elet,
a.orig_retif,
a.tp_proc,
a.nr_proc,
a.dt_term_afast,
ee.tpevento_infoexclusao,
ee.nrrec_evt_infoexclusao
from evt_afast_temp a
left join evt_exclusao ee on ee.nrrec_evt_infoexclusao = a.nr_recibo_entrega

WHERE a.nrinsc_ideempregador in ({cnpjs})
-- AND ee.nrrec_evt_infoexclusao IS NULL
