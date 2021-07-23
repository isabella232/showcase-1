<!doctype html>

<html lang="en">
<head>
  <meta charset="utf-8">

  <title>{{ project['name'] }}</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
  <link rel="stylesheet" href="/resources/modest.css">
  <link rel="stylesheet" href="/resources/styles.css">
</head>

<body>

<%
  trail = [
    ('Factory', '/'),
    ('Showcase', '/showcase/'),
    (project['name'], f"/incubator/{project['p_id']}")
  ]
  here = tab.capitalize()

  include('breadcrumbs.tpl', trail=trail, here=here)
%>

<div class="contents">
  <ul class="nav nav-tabs">
    <%
      for li in tabs:
        href = f"/incubator/{project['p_id']}/{li}"
        classes = "nav-link"
        if li == tab:
          classes = classes + " active"
        end
    %>
    <li class="nav-item">
      <a class="{{ classes }}" aria-current="page" href="{{ href }}">{{ li.capitalize() }}</a>
    </li>
    % end
  </ul>

  <div style="margin-top: 3em;">
  <%
    if tab == "technical":
      include(f'incubator/technical.tpl',
        project=project, lab=lab, is_active=is_active,
        maturity_label=maturity_label)
    else:
      from bottle import TemplateError

      p_id = project['p_id']

      try:
        include(f'incubator/{tab}/{p_id}.tpl')
      except TemplateError as exc:
        pass
      end
    end
  %>
  </div>

</div>

</body>
