SELECT
a.id_documento,
a.indretif_ideevento,
a.nrrecibo_ideevento,
a.indapuracao_ideevento,
a.perapur_ideevento,
a.indguia_ideevento,
a.tpamb_ideevento,
a.procemi_ideevento,
a.verproc_ideevento,
a.tpinsc_ideempregador,
a.nrinsc_ideempregador,
a.cpftrab_idetrabalhador,
a.indmv_infomv_idetrabalhador,
b.tpinsc_remunoutrempr,
b.nrinsc_remunoutrempr,
b.codcateg_remunoutrempr,
b.vlrremunoe_remunoutrempr,
a.nmtrab_infocomplem_idetrabalhador,
a.dtnascto_infocomplem_idetrabalhador,
a.tpinscant_sucessaovinc_infocomplem,
a.nrinsc_sucessaovinc_infocomplem,
a.matricant_sucessaovinc_infocomplem,
a.dtadm_sucessaovinc_infocomplem,
a.observacao_sucessaovinc_infocomplem,
c.tptrib_procjudtrab,
c.nrprocjud_procjudtrab,
c.codsuspprocjudtrab,
d.dia_infointerm,
e.cod_categ_dmdev,
e.indrra_dmdev,
e.tpprocrra_inforra,
e.nr_procrra_inforra,
e.descrra_inforra,
e.qtdmesesrra_inforra,
e.vlrdespcustas_despproc_jud,
e.vlrdespadvogados_despproc_jud,
f.tpinsc_ideadv,
f.nrinsc_ideadv,
f.vlradv_ideadv,
g.tpinsc_ideestablot,
g.nrinsc_ideestablot,
g.cotlotacao_ideestablot,
g.qtddiasav_ideestablot,
h.matricula_remunperapur,
h.indsimples_remunperapur,
i.codrubr_remunitens,
i.idetabrubr_remunitens,
i.qtdrubr_remunitens,
i.fatorrubr_remunitens,
i.vrrubrr_remunitens,
i.indapurir_remunitens,
h.grauexp_agnocivo_remunperapur,
j.dtacconv_ideadc_infoperant,
j.tpacconv_ideadc_infoperant,
j.dsc_ideadc_infoperant,
j.remunsuc_ideadc_infoperant,
k.perref_ideperiodo_infoperant,
l.tpinsc_ideestablot_infoperant,
l.nrinsc_ideestablot_infoperant,
l.codlotacao_ideestablot_infoperant,
m.matricula_remunperant_ideestablot,
m.indsimples_remunperant_ideestablot,
a.codcbo_infocomplcont,
a.natatividade_infocomplcont,
a.qtddiastrab_infocomplcont,
ee.tpevento_infoexclusao,
ee.nrrec_evt_infoexclusao

FROM evt_remun a

LEFT JOIN evt_remun_remun_outr_empr b
ON a.id = b.id_evtremun

LEFT JOIN evt_remun_proc_jud_trab c
ON a.id = c.id_evtremun

LEFT JOIN evt_remun_info_interm_ide_trabalhador d
ON a.id = d.id_evtremun

LEFT JOIN evt_remun_dm_dev e
ON a.id = e.id_evtremun

LEFT JOIN evt_remun_ide_adv f
ON e.id = f.id_evtremundmdev

LEFT JOIN evt_remun_estab_lot g
ON e.id = g.id_evtremundmdev

LEFT JOIN evt_remun_per_apur h
ON g.id = h.id_evtremunestab_lot

LEFT JOIN evt_remun_itens_remun i
ON h.id = i.id_evtremunperapur

LEFT JOIN evt_remun_info_per_ant j
ON e.id = j.id_evtremundmdev

LEFT JOIN evt_remun_ide_periodo_info_per_ant k
ON j.id = k.id_evtremun_infoperant

LEFT JOIN evt_remun_ide_estab_lot_info_per_ant l
ON k.id = l.id_evtremun_ideperiodo_infoperant

LEFT JOIN evt_remun_remun_per_ant_ide_estab_lot m
ON l.id = m.id_evtremun_ideestablot_infoperant

LEFT JOIN evt_exclusao ee
ON ee.nrrec_evt_infoexclusao = a.nr_recibo_entrega

WHERE a.nrinsc_ideempregador in ({cnpjs})
AND ee.nrrec_evt_infoexclusao IS NULL
AND a.perapur_ideevento BETWEEN '{data_inicio}' AND '{data_fim}'