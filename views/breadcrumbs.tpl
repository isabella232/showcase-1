<div class="breadcrumbs">
  % for label, link in trail:
    <a href="{{ link }}">{{ label }}</a>
    &gt;
  % end
  <b>{{ here }}</b>
</div>
