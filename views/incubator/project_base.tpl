<!doctype html>

<html lang="en">
<head>
  <meta charset="utf-8">

  <title>{{ project['name'] }}</title>

  <link rel="stylesheet" href="/resources/modest.css">
  <link rel="stylesheet" href="/resources/styles.css">
</head>

<body>

<%
  trail = [
    ('Factory', '/'),
    ('Incubator', '/incubator/'),
  ]
  here = project['name']

  include('breadcrumbs.tpl', trail=trail, here=here)
%>

<div class="contents">
  <h1>{{ project['name'] }}</h1>
  <div class="lab-title">
    <h4>{{ lab['name'] }} (<a href="{{ lab['url']}}">{{ lab['lab_id'] }}</a>)</h4>
  </div>

  <%
    from bottle import TemplateError

    p_id = project['p_id']

    try:
      include(f'incubator/{p_id}.tpl')
    except TemplateError as exc:
      pass
    end
  %>

  % if project['c4dt_work']:
  <h2>C4DT Factory contributions</h2>
  <p>
  {{ project['c4dt_work'] }}
  </p>
  % end

  <h2>Further information</h2>

  % if 'demo' in project:
  % demo = project['demo']
  <p>
  %   if 'url' in demo:
  A <a href="{{ demo['url'] }}">project demonstrator</a> is available.
  %   else:
  A demonstrator is currently being developed and will be available when ready.
  %   end
  </p>
  %   if 'description' in demo:
  {{ !demo['description'] }}
  <br>
  %   end
  % end

  % contact = project['c4dt_contact']
  <p>
  If you are interested in this project, please contact
  <a href="mailto:{{ contact['email'] }}">{{ contact['name'] }}</a>.
  </p>

</div>

</body>
