% for index, paper in enumerate(papers):
    <div>
    % paper_title = paper['title']
    % paper_url = paper['url']
    <a href="{{ paper_url }}">{{ paper_title }}</a>
    </div>
    % if index < len(papers) - 1:
    <br/>
    % end
% end
