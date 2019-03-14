<!doctype html>
<head>
    <link rel="stylesheet" type="text/css" href="/css/styles.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.5.6/css/buttons.dataTables.min.css"/>
    <script type="text/javascript" language="javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.colVis.min.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.html5.min.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.print.min.js"></script>
    <script type="text/javascript" class="init">
        $(document).ready(function() {
            var table = $('#projects').DataTable( {
                "paging": false,
                "scrollCollapse": true,
                "scrollY": "60vmin",
                "dom": "Bfrtip",
                "buttons": [
                    { text: "Columns", extend: 'colvis' },
                    // 'copy',
                    // 'csv',
                    // 'print',
                    {
                        text: "Clear search",
                        action: function(e, dt, node, config) { set_search(""); }
                    },
                ],
            } );

            // Hide "extra" columns by default
            table.columns(".extra").visible(false);
        } );

        function set_search(text) {
            var table = $('#projects').DataTable();
            table.search(text).draw();
        }
    </script>
</head>
<body>
    <div align="center">
        % if selected_lab_id is None:
            <h1>All projects</h1>
        % else:
            <h1>Projects at <em>{{ selected_lab_id }}</em></h1>
        % end
        <a href="/labs/">Back to list of labs</a>
        <table id="projects" class="display cell-border" style="width:100%">
            <thead>
                <tr>
                    <th>Lab</th>
                    <th>Project name</th>
                    <th>Description</th>
                    <th class="extra">Language</th>
                    <th>Source code</th>
                    <th>Tags</th>
                    <th>Contact</th>
                </tr>
            </thead>
            <tbody>
                % for lab_id, lab in labs.items():
                    % if selected_lab_id is None or selected_lab_id == lab_id:
                        % for project in lab['projects']:
                        <tr>
                            <%
                            name = project['name']
                            description = project['description']
                            url = project.get('url')
                            code = project['code']
                            tags = project['tags']
                            if tags is None:
                                tags = []
                            end
                            contacts = project['contacts']
                            %>
                            <td><a href="/projects/{{ lab_id }}">{{ lab_id }}</a></td>
                            % if url:
                            <td class="dt-nowrap"><a href="{{ url }}">{{ name }}</a></td>
                            % else:
                            <td>{{ name }}</td>
                            % end
                            <td>{{ description if description else 'N/A' }}</td>
                            <td>&lt;LANGUAGE&gt;</td>
                            % if code['url']:
                            <td class="dt-nowrap"><a href="{{ code['url'] }}">{{ code['type'] }}</a></td>
                            % else:
                            <td>{{ code['type'] if code['type'] else 'N/A' }}</td>
                            % end
                            <td class="dt-center">
                                % for tag in tags:
                                <button onclick="javascript:set_search('{{ tag }}')">{{ tag }}</button>
                                % end
                            </td>
                            <td class="dt-nowrap">
                                % include('contacts.tpl', contacts=contacts)
                            </td>
                        </tr>
                        % end
                    % end
                % end
            </tbody>
            <tfoot>
                <tr>
                    <th>Lab</th>
                    <th>Project name</th>
                    <th>Description</th>
                    <th>Language</th>
                    <th>Source code</th>
                    <th>Tags</th>
                    <th>Contact</th>
                </tr>
            </tfoot>
        </table>
    </div>
</body>
