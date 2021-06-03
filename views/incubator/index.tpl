<!doctype html>

<html lang="en">
<head>
  <meta charset="utf-8">

  <title>C4DT Incubator</title>

  <link rel="stylesheet" href="/resources/modest.css">
  <link rel="stylesheet" href="/resources/styles.css">
</head>

<body>

<%
  trail = [
    ('Factory', '/'),
  ]
  here = 'Incubator'

  include('breadcrumbs.tpl', trail=trail, here=here)
%>

<div class="contents">
  <h1>C4DT Incubator</h1>

  <p>
  These are the current projects on which the C4DT Factory team is working.
  <p/>

  % for project in projects:
  <hr/>
  <h2>{{ project['name'] }}</h2>
  <div class="lab-title">
    <h4>{{ project['lab']['name'] }} (<a href="{{ project['lab']['url']}}">{{ project['lab']['lab_id'] }}</a>)</h4>
  </div>

  <div class="index-image">
    <img src="/resources/incubator/images/index/{{ project['p_id'] }}.png" alt="">
  </div>

  <p>
  {{ project['layman_desc'] }}
  <p/>

  <ul>
    <li>
      <p>Read the <a href="{{ project['p_id'] }}">project presentation</a></p>
    </li>

  % if 'demo' in project:
  %   demo = project['demo']
    <li>
  %   if 'url' in demo:
      <p>Visit the <a href="{{ demo['url'] }}">project demonstrator</a></p>
  %   else:
      <p>A demonstrator is currently being developed and will be available when ready</p>
  %   end
    </li>
  %   if 'description' in demo:
  {{ !demo['description'] }}
  %   end
  % end

  </ul>

  <br/>

  % end
</div>

</body>
