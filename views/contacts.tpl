% for contact in contacts:
<div>
    % contact_name = contact['name']
    % contact_email = contact.get('email')
    % contact_url = contact.get('url')
    % if contact_email:
    <a href="mailto:{{ contact_email }}">{{ contact_name }}</a>
    % elif contact_url:
    <a href="{{ contact_url }}">{{ contact_name }}</a>
    % else:
    {{ contact_name }}
    % end
</div>
% end
