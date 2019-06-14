% for paper in papers:
<div>
    % paper_title = paper['title']
    % paper_url = paper['url']
    <a href="{{ paper_url }}">{{ paper_title }}</a>
</div>
% end
