<#include "dml_json.ftl">
<#list objects as object>
//file ${object.objectName}Provider.java
package ru.fccland.aki.universalreport.provider;

import net.sf.jasperreports.engine.JRException;
import ru.fccland.aki.report.dao.UniversalReportDao;
import ru.fccland.aki.universalreport.util.DataSourceUtil;
import ru.fccland.rki.common.vo.Engineer${object.objectName}VO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by haste on 08.09.16.
 */
public class ${object.objectName}Provider {

    Map<Long, List <Engineer${object.objectName}VO>> ${object.objectName?lower_case}Map;

    List<Long> engineerIds;

    UniversalReportDao universalReportDao;

    DataSourceUtil dataSourceUtil = new DataSourceUtil();

    public ${object.objectName}Provider(UniversalReportDao universalReportDao, List<Long> engineerIds) {
        this.universalReportDao = universalReportDao;
        this.engineerIds = engineerIds;
    }
    /**
     * Conversion List<${object.objectName}> to Map<Long, List<${object.objectName}>>
     * @return Map<Long, List<${object.objectName}>>
     * @throws JRException
     */
    public Map<Long, List<Engineer${object.objectName}VO>> getData() throws JRException {

        List<Engineer${object.objectName}VO> ${object.objectName?lower_case}List = new ArrayList<Engineer${object.objectName}VO>();
        for (List<Long> engIds : dataSourceUtil.splitListData(engineerIds)) {
            ${object.objectName?lower_case}List.addAll(universalReportDao.get${object.objectName}List(engIds));
        }
        // ${object.objectName?lower_case}List = dataSourceUtil.format${object.objectName}(${object.objectName?lower_case}List);
        ${object.objectName?lower_case}Map = new HashMap<Long, List<Engineer${object.objectName}VO>>(${object.objectName?lower_case}List.size());

        for (Engineer${object.objectName}VO ${object.objectName?lower_case} : ${object.objectName?lower_case}List) {
            if (${object.objectName?lower_case}Map.get(${object.objectName?lower_case}.getEngineerId()) == null) {
                List<Engineer${object.objectName}VO> new${object.objectName}List = new ArrayList<Engineer${object.objectName}VO>();
                new${object.objectName}List.add(${object.objectName?lower_case});
                ${object.objectName?lower_case}Map.put(${object.objectName?lower_case}.getEngineerId(), new${object.objectName}List);
            } else {
                ${object.objectName?lower_case}Map.get(${object.objectName?lower_case}.getEngineerId()).add(${object.objectName?lower_case});
            }
        }
        return ${object.objectName?lower_case}Map;
    }
}
//end of file ${object.objectName}Provider.java

</#list>