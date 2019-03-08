<head>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css"/>
    <script type="text/javascript" language="javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" class="init">
        $(document).ready(function() {
            $('#projects').DataTable( {
                "paging": false,
                "scrollCollapse": true,
                "scrollY": "60vmin",
            } );
        } );
    </script>
</head>
<body>
    <div align="center">
        %if lab_id is None:
            <h1>All projects</h1>
        %else:
            <h1>Projects at <em>{{lab_id}}</em></h1>
        %end
        <a href="/labs/">Back to list of labs</a>
        <table id="projects" class="display" style="width:100%">
            <thead>
                <tr>
                    <th>Lab</th>
                    <th>Project name</th>
                    <th>Description</th>
                    <th>Source code</th>
                    <th>Contact</th>
                </tr>
            </thead>
            <tbody>
                %for project in data:
                <tr>
                    %lab = project['lab_id']
                    %name = project['name']
                    %description = project['description']
                    %url = project.get('url')
                    %code = project['code']
                    %contacts = project['contacts']
                    <td><a href="/lab_projects/{{lab}}">{{lab}}</a></td>
                    %if url:
                        <td><a href="{{url}}">{{name}}</a></td>
                    %else:
                        <td>{{name}}</td>
                    %end
                    <td>{{description}}</td>
                    %if code['url']:
                        <td><a href="{{code['url']}}">{{code['type']}}</a></td>
                    %else:
                        <td>{{code['type']}}</td>
                    %end
                    <td>
                        %if contacts is None:
                            N/A
                        %else:
                            %for contact in contacts:
                                <div>
                                %contact_name = contact['name']
                                %contact_email = contact.get('email')
                                %contact_url = contact.get('url')
                                %if contact_email:
                                    <a href="mailto:{{contact_email}}">{{contact_name}}</a>
                                %elif contact_url:
                                    <a href="{{contact_url}}">{{contact_name}}</a>
                                %else:
                                    {{contact_name}}
                                %end
                                </div>
                            %end
                        %end
                    </td>
                </tr>
                %end
            </tbody>
            <tfoot>
                <tr>
                    <th>Lab</th>
                    <th>Project name</th>
                    <th>Description</th>
                    <th>Source code</th>
                    <th>Contact</th>
                </tr>
            </tfoot>
        </table>
    </div>
</body>
