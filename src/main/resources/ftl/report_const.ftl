<#include "const.ftl" >

package ru.fccland.rki.web.common;

/**
* Created by haste on 14.09.16.
*/
public interface ReportConst {

<#list objects as object>
    String ${getReportName(object)} = "${getReportName(object)}";
</#list>

}
