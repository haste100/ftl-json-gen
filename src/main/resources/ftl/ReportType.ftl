<#list objects as object>
    UNIVERSAL_SUBREPORT_${object.objectName?upper_case} {
        public String getTemplateName() {
            return "subreport_${object.objectName?lower_case}.jrxml";
        }
    },
</#list>