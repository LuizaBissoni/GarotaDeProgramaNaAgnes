SELECT
a.id_documento,
a.indretif_ideevento,
a.nrrecibo_ideevento,
a.tpamb_ideevento,
a.procemi_ideevento,
a.verproc_ideevento,
a.tpinsc_ideempregador,
a.nrinsc_ideempregador,
a.cpfbenef_beneficiario,
a.nmbenefic_beneficiario,
a.dtnascto_beneficiario,
a.dtinicio_beneficiario,
a.sexo_beneficiario,
a.racacor_beneficiario,
a.estciv_beneficiario,
a.incfismen_beneficiario,
a.dtincfismen_beneficiario,
a.tplograd_brasil,
a.dsclograd_brasil,
a.nrlograd_brasil,
a.complemento_brasil,
a.bairro_brasil,
a.cep_brasil,
a.codmunic_brasil,
a.uf_brasil,
a.paisresid_exterior,
a.dsclograd_exterior,
a.nrlograd_exterior,
a.complemento_exterior,
a.bairro_exterior,
a.nmcid_exterior,
a.codpostal_exterior,
b.tpdep_dependente,
b.nmdep_dependente,
b.dtnascto_dependente,
b.cpfdep_dependente,
b.sexodep_dependente,
b.depirrf_dependente,
b.incfismen_dependente

FROM evt_cd_benef_in a

LEFT JOIN evt_cd_benef_in_dependente_beneficiario b
ON a.id = b.id_evt_cd_benef_in

WHERE LEFT(a.nrinsc_ideempregador,8) = '{cnpj}'
AND a.perapur_ideevento BETWEEN '{data_inicio}' AND '{data_fim}'