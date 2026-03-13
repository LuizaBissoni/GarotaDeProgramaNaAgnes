select
a.id,
a.indretif_ideevento,
a.nrrecibo_ideevento,
a.indapuracao_ideevento,
a.perapur_ideevento,
a.tpamb_ideevento,
a.procemi_ideevento,
a.verproc_ideevento,
a.tpinsc_ideempregador,
a.nrinsc_ideempregador,
a.cpftrab_idetrabalhador,
a.nm_trab_infocomplem,
a.dtnascto_infocomplem,
a.cnpj_orgaant_sucessaovinc,
a.matricant_sucessaovinc,
a.dtexercicio_sucessaovinc,
a.observacao_sucessaovinc,
b.idedmdev_dmdev,
b.codcateg_dmdev,
b.indrra_dmdev,
b.inforra_tpprocrra_dmdev,
b.inforranr_procrra_dmdev,
b.inforra_descrra_dmdev,
b.inforra_qtdmesesrra_dmdev,
b.inforra_despprocjud_vlrdespcustas_dmdev,
b.inforra_despprocjud_vlrdespadvogados_dmdev,
g.tp_insc,
g.nr_insc,
g.vlr_adv,
c.tpinsc_ideestab,
c.nrinsc_ideestab,
d.matricula_remunperapur,
e.codrubr_itensremun,
e.idetabrubr_itensremun,
e.qtdrubr_itensremun,
e.fatorrubr_itensremun,
e.vrrubr_itensremun,
e.indapurir_itensremun,
b.remunorgsuc_infperant,
f.perref_ideperiodo,
c.tpinsc_ideestab,
c.nrinsc_ideestab,
ee.tpevento_infoexclusao,
ee.nrrec_evt_infoexclusao
from evt_rmnrpps a
left join evt_rmnrppsdm_dev b on a.id = b.id_evtrmnrpps
left join evt_rmnrppside_estab_info_per_apur c on b.id = c.id_evtrmnrpps_dmdev
left join evt_rmnrppsremun_per_apur_ide_estab d on c.id = d.id_evtrmnrpps_ideestab_infoperapur
left join evt_rmnrppsitens_remun_remun_per_apur e on d.id = e.id_evtrmnrpps_remunper_apur_ideestab
left join evt_rmnrppside_periodo_info_per_ant f on b.id = f.id_evtrmnrpps_dmdev
left join evt_rmnrpps_evt_rmnrpps_dmdev_inforra_ideadv g on b.id = g.id_evtrmnrpps_dmdev
left join evt_exclusao ee on ee.nrrec_evt_infoexclusao = a.nr_recibo_entrega

WHERE LEFT(a.nrinsc_ideempregador,8) = '{cnpj}'
AND a.perapur_ideevento BETWEEN '{data_inicio}' AND '{data_fim}'