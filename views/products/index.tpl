<!doctype html>

<html lang="en">
<head>
  <meta charset="utf-8">

  <title>{{ project['name'] }} - {{product.capitalize()}}</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
  <link rel="stylesheet" href="/resources/modest.css">
  <link rel="stylesheet" href="/resources/styles.css">
  <link rel="stylesheet" href="/resources/products.css">
</head>

<body>

<%
  trail = [
    ('Factory', '/'),
    ('Showcase', '/showcase/'),
  ]
  here = project['name']

  include('breadcrumbs.tpl', trail=trail, here=here)
%>

  <div class="products-header">
    <ul class="nav nav-tabs">
      <%
        for li in products:
          href = f"/showcase/{project['p_id']}/{li}"
          classes = "nav-link"
          image_class = "dark_invert"
          if li == product:
            classes = classes + " active"
            image_class = ""
          end
      %>
      <li class="nav-item">
        <a class="{{ classes }}" aria-current="page" href="{{ href }}">
          <img src="../../resources/products/icons/{{ li }}.png" class="{{ image_class }}"
               style="width: 2em; height: 2em; padding: 0.2em;"/>
          {{ li.capitalize() }}
        </a>
      </li>
      % end
    </ul>
  </div>

  <div class="products-text">
  <%
    if product == "technical":
      include(f'products/technical.tpl',
        project=project, lab=lab, is_active=is_active,
        maturity_label=maturity_label)
    else:
      from bottle import TemplateError

      p_id = project['p_id']

      try:
        include(f'products/{product}/{p_id}.tpl')
      except TemplateError as exc:
        pass
      end
    end
  %>
  </div>
</body>
