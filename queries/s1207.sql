SELECT
a.id_documento,
a.indretif_ideevento,
a.nrrecibo_ideevento,
a.indapuracao_ideevento,
a.tpamb_ideevento,
a.procemi_ideevento,
a.verproc_ideevento,
a.tpinsc_ideempregador,
a.nrinsc_ideempregador,
a.cpfbenef_idebenef,
b.idedmdev_dmdev,
b.nrbenefic_dmdev,
b.indrra_dmdev,
b.tpprocrra_inforra_dmdev,
b.nrprocrra_inforra_dmdev,
b.descrra_inforra_dmdev,
b.qtdmesesrra_inforra_dmdev,
b.vlrdespcustas_despprocjud_inforra_dmdev,
b.vlrdespadvogados_despprocjud_inforra_dmdev,
c.tp_insc,
c.nr_insc,
c.vlr_adv,
d.nrinsc_ideestab,
d.tpinsc_ideestab,
e.codrubr_itensremun,
e.idetabrubr_itensremun,
e.qtdrubr_itensremun,
e.fatorrubr_itensremun,
e.vrrubr_itensremun,
e.indapurir_itensremun

FROM evt_benprrp a

LEFT JOIN evt_ben_prrpdm_dev b
ON a.id = b.id_evtbenprrp

LEFT JOIN evt_ben_prrpide_inforra_ide_adv c
ON a.id = c.id_evtbenprrp_dmdev

LEFT JOIN evt_ben_prrpide_estab_infoperapur d
ON a.id = d.id_evtbenprrp_dmdev

LEFT JOIN evt_ben_prrpitens_remun_ide_estab_infoperapur e
ON a.id = e.id_evtbenprrp_ideestab_infoperapur

WHERE LEFT(a.nrinsc_ideempregador,8) = '{cnpj}'
AND a.perapur_ideevento BETWEEN '{data_inicio}' AND '{data_fim}'