<!doctype html>
<head>
    <link rel="stylesheet" type="text/css" href="/css/styles.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css"/>
    <script type="text/javascript" language="javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" class="init">
        $(document).ready(function() {
            table = $('#projects').DataTable( {
                "paging": false,
                "scrollCollapse": true,
                "scrollY": "60vmin",
            } );
        } );
    </script>
</head>
<body>
    <div align="center">
        %if selected_lab_id is None:
            <h1>All projects</h1>
        %else:
            <h1>Projects at <em>{{selected_lab_id}}</em></h1>
        %end
        <a href="/labs/">Back to list of labs</a>
        <table id="projects" class="display cell-border" style="width:100%">
            <thead>
                <tr>
                    <th>Lab</th>
                    <th>Project name</th>
                    <th>Description</th>
                    <th>Source code</th>
                    <th>Tags</th>
                    <th>Contact</th>
                </tr>
            </thead>
            <tbody>
                %for lab_id, lab in labs.items():
                    %if selected_lab_id is None or selected_lab_id == lab_id:
                        %for project in lab['projects']:
                        <tr>
                            %name = project['name']
                            %description = project['description']
                            %url = project.get('url')
                            %code = project['code']
                            %tags = project['tags']
                            %if tags is None:
                                %tags = []
                            %end
                            %contacts = project['contacts']
                            <td><a href="/projects/{{lab_id}}">{{lab_id}}</a></td>
                            %if url:
                            <td class="dt-nowrap"><a href="{{url}}">{{name}}</a></td>
                            %else:
                            <td>{{name}}</td>
                            %end
                            <td>{{description}}</td>
                            %if code['url']:
                            <td class="dt-nowrap"><a href="{{code['url']}}">{{code['type']}}</a></td>
                            %else:
                            <td>{{code['type']}}</td>
                            %end
                            <td class="dt-center">
                                %for tag in tags:
                                <button onclick="javascript:table.search('{{tag}}').draw()">{{tag}}</button>
                                %end
                            </td>
                            <td class="dt-nowrap">
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
                    %end
                %end
            </tbody>
            <tfoot>
                <tr>
                    <th>Lab</th>
                    <th>Project name</th>
                    <th>Description</th>
                    <th>Source code</th>
                    <th>Tags</th>
                    <th>Contact</th>
                </tr>
            </tfoot>
        </table>
    </div>
</body>
