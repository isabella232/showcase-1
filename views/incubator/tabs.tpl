<!doctype html>

<html lang="en">
<head>
  <meta charset="utf-8">

  <title>{{ project['name'] }}</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
  <link rel="stylesheet" href="/resources/modest.css">
  <link rel="stylesheet" href="/resources/styles.css">
  <link rel="stylesheet" href="/resources/tabs.css">
</head>

<body>

<%
  trail = [
    ('Factory', '/'),
    ('Showcase', '/showcase/'),
  ]
  here = project['name'].capitalize()

  include('breadcrumbs.tpl', trail=trail, here=here)
%>

  <div class="tabs-header">
    <ul class="nav nav-tabs">
      <%
        for li in tabs:
          href = f"/incubator/{project['p_id']}/{li}"
          classes = "nav-link"
          image_class = "dark_invert"
          if li == tab:
            classes = classes + " active"
            image_class = ""
          end
      %>
      <li class="nav-item">
        <a class="{{ classes }}" aria-current="page" href="{{ href }}">
          <img src="../../resources/incubator/icons/{{ li }}.png" class="{{ image_class }}"
               style="width: 2em; height: 2em; padding: 0.2em;"/>
          {{ li.capitalize() }}
        </a>
      </li>
      % end
    </ul>
  </div>

  <div class="tabs-text">
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
</body>
