<#include "dml_json.ftl" >
//init map
<#list objects as object>
params.put("${object.objectName?upper_case}_MAP", null);
</#list>

//fill map
<#list objects as object>
    // ${object.objectName} Subreport
    if(params.get("${getReportName(object)}") != null){
        log.info("Start generate ${getReportName(object)} query and dataSourse: " + new Date().toString());
        ${object.objectName}Provider ${object.objectName?lower_case}Provider = new ${object.objectName}Provider(universalReportDao, engineerDs.getEngineersIds());
        Map<Long, List<Engineer${object.objectName}VO>> ${object.objectName?lower_case}Map = ${object.objectName?lower_case}Provider.getData();
        log.info("End generate ${getReportName(object)} query and dataSourse: " + new Date().toString());
        params.put("${object.objectName?upper_case}_MAP", ${object.objectName?lower_case}Map);
    }
</#list>
