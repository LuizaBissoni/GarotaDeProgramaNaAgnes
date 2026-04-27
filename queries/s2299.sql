select
a.id_documento,
a.indretif_ideevento,
a.nrrecibo_ideevento,
a.indguia_ideevento,
a.tpamb_ideevento,
a.procemi_ideevento,
a.verproc_ideevento,
a.tpinsc_ideempregador,
a.nrinsc_ideempregador,
a.cpftrab_idevinculo,
a.matricula_idevinculo,
a.mtvdeslig_infodeslig,
a.dtdeslig_infodeslig,
a.dtavprv_infodeslig,
a.indpagtoapi_infodeslig,
a.dtprojfimapi_infodeslig,
a.pensalim_infodeslig,
a.percaliment_infodeslig,
a.vralim_infodeslig,
a.nrproctrab_infodeslig,
a.indpdv_infodeslig,
b.dia_infointerm,
c.observacao_observacoes,
a.tpinscsuc_infodeslig,
a.nrinscsuc_infodeslig,
a.cpfsubstituto_infodeslig,
a.dtnascto_infodeslig,
a.novocpf_infodeslig,
d.idedmdev_dmdevverbasresc,
d.ind_rra,
d.tpproc_rra,
d.nrproc_rra,
d.desc_rra,
d.qtdmeses_rra,
d.vlrdespcustas_despprocjud,
d.vlrdespadvogados_despprocjud,
e.tp_insc,
e.nr_insc,
e.vlr_adv,
h.tpinsc_dmdevideestablot,
h.nrinsc_dmdevideestablot,
h.codlotacao_dmdevideestablot,
n.codrubr_infoperapu_detverbas,
n.idetabrubr_infoperapu_detverbas,
n.qtdrubr_infoperapu_detverbas,
n.fatorrubr_infoperapu_detverbas,
n.vrrubr_infoperapu_detverbas,
n.indapurir_infoperapu_detverbas,
h.grauexp_dmdevideestablotinfoagnocivo,
h.indsimples_dmdevideestablotinfosimples,
f.dtacconv_ideadc,
f.tpacconv_ideadc,
f.dsc_ideadc,
g.perref_dmdevideperiodo,
j.tptrib_evtdesligprocjudtrab,
j.nrprocjud_evtdesligprocjudtrab,
j.codsusp_evtdesligprocjudtrab,
a.indmv_infomv,
k.tpinsc_evtdeslig_infomv_remun_outrasempresas,
k.nrinsc_evtdeslig_infomv_remun_outrasempresas,
k.codcateg_evtdeslig_infomv_remun_outrasempresas,
k.vlrremunoee_evtdeslig_infomv_remun_outrasempresas,
a.nrprocjud_proccs,
a.indremun_remunaposdeslig_infodeslig,
l.insconsig_configfgts,
l.nrcontr_configfgts,
ee.tpevento_infoexclusao,
ee.nrrec_evt_infoexclusao
from evt_deslig a
left join evt_deslig_info_interm_info_deslig b on a.id = b.id_evtdeslig
left join evt_deslig_observacoes c on a.id = c.id_evtdeslig
left join evt_deslig_dm_dev d on a.id = d.id_evtdeslig
left join evt_deslig_dm_dev_inforra_ideadv e on d.id = e.id_evtdesligdmdev
left join evt_deslig_dm_dev_ideadc f on d.id = f.id_evtdesligdmdev
left join evt_deslig_dm_dev_ide_periodo g on f.id = g.id_evtdesligdmdev_ideadc
left join evt_deslig_dm_dev_ide_estab_lot h on f.id = h.id_evtdeslig_ideperiodo
left join evt_deslig_proc_jud_trab j on a.id = j.id_evtdeslig
left join evt_deslig_infomvremun_outras_empresas k on a.id = k.id_evtdeslig
left join evt_deslig_consigfgts l on a.id = l.id_evtdeslig
left join evt_deslig_dm_dev_info_per_apur_ide_estab_lot m on d.id = m.id_evtdesligdmdev
left join evt_deslig_info_per_apur_det_verbas n on m.id = n.id_evtdeslig_infoperapur_ideetablot
left join evt_exclusao ee on ee.nrrec_evt_infoexclusao = a.nr_recibo_entrega

WHERE a.nrinsc_ideempregador in ({cnpjs})
-- AND ee.nrrec_evt_infoexclusao IS NULL