--[[ Escreve um campo com a formatação correta --]]
return function (title, field, value, extra)
  return string.format([[
      <tr>
        <td width="24%%" align="right"><font face="Arial">%s</font></td>
        <td width="76%%"><font face="Arial">&nbsp;<textarea rows="1" name="%s"
                          cols="30">%s</textarea>
        <font size="2" color="#0000FF">%s</font></font></td>
      </tr>
    ]], title, field, value or '', extra or '')
end
