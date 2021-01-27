<a href="{{ info['url'] }}">{{ info['title'] }}</a>
<%
for note in info.get('notes', []):
    note_label = note.get('label')
    note_text = note['text']
    note_url = note.get('url')
%>
    —
    % if note_label:
    {{ note_label }}:
    % end
    % if note_url:
    <a href="{{ note_url }}">{{ note_text }}</a>
    % else:
    {{ note_text }}
    % end
% end
