<#setting number_format="######.##">
<#include "dml_json.ftl" >
<#list objects as object>
<!-- file subreport_${object.objectName?lower_case}.jrxml -->
<?xml version="1.0" encoding="UTF-8"?>
<jasperReport xmlns="http://jasperreports.sourceforge.net/jasperreports" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://jasperreports.sourceforge.net/jasperreports http://jasperreports.sourceforge.net/xsd/jasperreport.xsd" name="subreport_education" pageWidth="${getObjectWidth(object)}" pageHeight="42" orientation="Landscape" whenNoDataType="NoDataSection" columnWidth="700" leftMargin="0" rightMargin="0" topMargin="0" bottomMargin="0" isIgnorePagination="true">
    <property name="ireport.zoom" value="1.0"/>
    <property name="ireport.x" value="0"/>
    <property name="ireport.y" value="0"/>
    <parameter name="id" class="java.lang.Long" isForPrompting="false"/>
    <#list object.fields as field>
        <#if isString(field)>
    <field name="${getName(field)}" class="java.lang.String"/>
        <#elseif isCombobox(field) || isRadio(field)>
    <field name="${getName(field)}Desc" class="java.lang.String"/>
        <#elseif isDate(field)>
    <field name="${getName(field)}" class="java.util.Date"/>
        </#if>
    </#list>
    <background>
        <band splitType="Stretch"/>
    </background>
    <detail>
        <band height="42" splitType="Stretch">
    <#assign x=0 />
    <#list object.fields as field>
        <#if isString(field)>
            <textField>
                <reportElement x="${x}" y="0" width="${getWidth(field)}" height="42"/>
                <textElement textAlignment="Center" verticalAlignment="Middle"/>
                <textFieldExpression class="java.lang.String"><![CDATA[$F{${getName(field)}}]]></textFieldExpression>
            </textField>
        <#elseif isCombobox(field) || isRadio(field)>
            <textField>
                <reportElement x="${x}" y="0" width="${getWidth(field)}" height="42"/>
                <textElement textAlignment="Center" verticalAlignment="Middle"/>
                <textFieldExpression class="java.lang.String"><![CDATA[$F{${getName(field)}Desc}]]></textFieldExpression>
            </textField>
        <#elseif isDate(field)>
            <textField pattern="dd.MM.yyyy">
                <reportElement x="${x}" y="0" width="${getWidth(field)}" height="42"/>
                <textElement textAlignment="Center" verticalAlignment="Middle"/>
                <textFieldExpression class="java.util.Date"><![CDATA[$F{${getName(field)}}]]></textFieldExpression>
            </textField>
        </#if>
        <#assign x += getWidth(field)?number />
    </#list>
        </band>
    </detail>
    <noData>
        <band height="42"/>
    </noData>
</jasperReport>
<!-- end of file subreport_${object.objectName?lower_case}.jrxml -->

</#list>
