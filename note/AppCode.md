### Live Templates
模板保存路径：/Users/blf/Library/Application\ Support/JetBrains/AppCode2021.2/templates/Swift.xml

模板示例：
``` xml
<templateSet group="Swift">
  <template name="ifemployer" value="if UserCenter.shared.userModel.value?.roleType == .employe {&#10;    &#10;}" description="判断角色" toReformat="true" toShortenFQNames="true">
    <context>
      <option name="swift.lang.context" value="true" />
    </context>
  </template>
  <template name="myscl" value="$ImageView$.layer.cornerRadius = 10&#10;$ImageView$.layer.borderWidth = 1&#10;$ImageView$.layer.borderColor = lTheme.grayLight.cgColor&#10;$ImageView$.kf.setAvatarImage(with: $URLString$)&#10;$END$" description="设置公司logo" toReformat="true" toShortenFQNames="true">
    <variable name="ImageView" expression="&quot;ImageView&quot;" defaultValue="" alwaysStopAt="true" />
    <variable name="URLString" expression="&quot;urlString&quot;" defaultValue="" alwaysStopAt="true" />
    <context>
      <option name="swift.lang.context" value="true" />
    </context>
  </template>
</templateSet>
```
