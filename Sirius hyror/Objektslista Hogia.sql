select cc.name, ce.estate_ref, ch.formatted_address_street, ch.hireableobject_oldref, ch.formatted_reference, ch.formatted_address_full,
       cc3.formatted_name, ch.floorarea, c.baserent_excl*12 as årshyra
from company_hireableobject ch
join company_estate ce on ch.hireableobject_estate_id_id = ce.estate_id
join company_company cc on ce.estate_company_id = cc.company_id
join company_horentpermonth c on ch.hireableobject_id = c.hireable_object_id
join (
    select distinct cc2.hireable_object_id, ct.formatted_name
    from company_contractagreement cc2
    join company_tenant ct on cc2.primary_applicant_id = ct.id
    where cc2.formatted_contract_start <='2022-05-01' and cc2.formatted_contract_status <5 and cc2.formatted_contract_status>0
    group by cc2.hireable_object_id, ct.formatted_name
) cc3 on ch.hireableobject_id = cc3.hireable_object_id
where cc.name like '%Sir.%' and c.yearmonth='2022-06-01'
order by cc.name, ce.estate_ref, ch.formatted_address_street, ch.hireableobject_oldref, ch.formatted_reference
