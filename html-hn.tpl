<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>{{- escapeXML ( index . 0 ).Target }} - Trivy Report - {{ now }}</title>
    <style>
      * {
        font-family: 'Arial', 'Helvetica', sans-serif;
        margin: 0;
        padding: 0;
      }
      body {
        background-color: #f4f7f9;
        color: #333;
        padding: 20px;
      }
      h1 {
        text-align: center;
        color: #2c3e50;
        font-size: 32px;
        margin-bottom: 30px;
      }
      .group-header th {
        font-size: 200%;
        text-align: center;
        background-color: #2c3e50;
        color: white;
        padding: 10px;
      }
      .sub-header th {
        font-size: 120%;
        background-color: #34495e;
        color: white;
        padding: 8px;
      }
      table, th, td {
        border: 1px solid #ddd;
        border-collapse: collapse;
        padding: 8px;
        text-align: left;
      }
      table {
        width: 100%;
        margin-bottom: 30px;
        background-color: #fff;
        border-radius: 8px;
      }
      th {
        background-color: #ecf0f1;
      }
      .severity {
        font-weight: bold;
        padding: 3px;
        text-align: center;
      }
      .severity-LOW .severity { background-color: #5fbb31; color: #fff; }
      .severity-MEDIUM .severity { background-color: #e9c600; color: #fff; }
      .severity-HIGH .severity { background-color: #ff8800; color: #fff; }
      .severity-CRITICAL .severity { background-color: #e40000; color: #fff; }
      .severity-UNKNOWN .severity { background-color: #747474; color: #fff; }
      .links a {
        color: #3498db;
        text-decoration: none;
      }
      .links a:hover {
        text-decoration: underline;
      }
      .footer {
        text-align: center;
        margin-top: 50px;
        font-size: 14px;
        color: #7f8c8d;
      }
      .footer a {
        color: #3498db;
        text-decoration: none;
      }
      .footer a:hover {
        text-decoration: underline;
      }
    </style>
    <script>
      window.onload = function() {
        document.querySelectorAll('td.links').forEach(function(linkCell) {
          var links = [].concat.apply([], linkCell.querySelectorAll('a'));
          [].sort.apply(links, function(a, b) {
            return a.href > b.href ? 1 : -1;
          });
          links.forEach(function(link, idx) {
            if (links.length > 3 && 3 === idx) {
              var toggleLink = document.createElement('a');
              toggleLink.innerText = "Toggle more links";
              toggleLink.href = "#toggleMore";
              toggleLink.setAttribute("class", "toggle-more-links");
              linkCell.appendChild(toggleLink);
            }
            linkCell.appendChild(link);
          });
        });
        document.querySelectorAll('a.toggle-more-links').forEach(function(toggleLink) {
          toggleLink.onclick = function() {
            var expanded = toggleLink.parentElement.getAttribute("data-more-links");
            toggleLink.parentElement.setAttribute("data-more-links", "on" === expanded ? "off" : "on");
            return false;
          };
        });
      };
    </script>
  </head>
  <body>
    <h1>{{- escapeXML ( index . 0 ).Target }} - Trivy Report</h1>
    <table>
      {{- range . }}
        <tr class="group-header">
          <th colspan="6">{{ .Type | toString | escapeXML }}</th>
        </tr>
        {{- if (eq (len .Vulnerabilities) 0) }}
          <tr><th colspan="6">No Vulnerabilities found</th></tr>
        {{- else }}
          <tr class="sub-header">
            <th>Package</th>
            <th>Vulnerability ID</th>
            <th>Severity</th>
            <th>Installed Version</th>
            <th>Fixed Version</th>
            <th>Links</th>
          </tr>
          {{- range .Vulnerabilities }}
            <tr class="severity-{{ .Severity | lower }}">
              <td class="pkg-name">{{ .PkgName }}</td>
              <td>{{ .VulnerabilityID }}</td>
              <td class="severity">{{ .Severity }}</td>
              <td class="pkg-version">{{ .InstalledVersion }}</td>
              <td>{{ .FixedVersion }}</td>
              <td class="links" data-more-links="off">
                {{- range .References }}
                  <a href="{{ . }}">{{ . }}</a>
                {{- end }}
              </td>
            </tr>
          {{- end }}
        {{- end }}

        {{- if (eq (len .Misconfigurations) 0) }}
          <tr><th colspan="6">No Misconfigurations found</th></tr>
        {{- else }}
          <tr class="sub-header">
            <th>Type</th>
            <th>Misconf ID</th>
            <th>Check</th>
            <th>Severity</th>
            <th>Message</th>
            <th>Links</th>
          </tr>
          {{- range .Misconfigurations }}
            <tr class="severity-{{ .Severity | lower }}">
              <td class="misconf-type">{{ .Type }}</td>
              <td>{{ .ID }}</td>
              <td class="misconf-check">{{ .Title }}</td>
              <td class="severity">{{ .Severity }}</td>
              <td class="link" data-more-links="off" style="white-space:normal;">
                {{ .Message }} <br>
                <a href="{{ .PrimaryURL }}">{{ .PrimaryURL }}</a>
              </td>
            </tr>
          {{- end }}
        {{- end }}
      {{- end }}
    </table>
    <div class="footer">
      <p>Created by <a href="mailto:abdul.rehman@hypernymbiz.com">abdul.rehman@hypernymbiz.com</a></p>
    </div>
  </body>
</html>

