<!doctype html>
<head>
    <link rel="stylesheet" type="text/css" href="/resources/styles.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.5.6/css/buttons.dataTables.min.css"/>
    <title>C4DT showcase labs</title>
    <script type="text/javascript" language="javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.colVis.min.js"></script>
    <script type="text/javascript" class="init">
        $(document).ready(function() {
            var table = $('#labs').DataTable( {
                "paging": false,
                "scrollCollapse": true,
                "scrollY": "60vmin",
            } );

            // Hide "extra" columns by default
            table.columns(".extra").visible(false);
        } );

        function set_search(text) {
            var table = $('#labs').DataTable();
            table.search(text).draw();
        }
    </script>
</head>
<body>
    <%
        trail = [
            ('Factory', 'https://www.c4dt.org/factory/'),
            ('Showcase', '/projects/'),
        ]
        here = 'Labs'

        include('breadcrumbs.tpl', trail=trail, here=here)
    %>

    <div align="center">
        <h1>Participating EPFL Laboratories</h1>
        <table id="labs" class="display cell-border" style="width:100%">
            <thead>
                <tr>
                    <th>Lab Projects</th>
                    <th>Official Lab Page</th>
                    <th>Professor</th>
                </tr>
            </thead>
            <tbody>
                % for lab_id, lab in labs.items():
                <tr>
                    <td><a href="/projects/{{ lab_id }}">{{ lab_id }}</a></td>
                    <td>
                        <a href="{{ lab['url'] }}">{{ lab['name'] }}</a>
                    </td>
                    % prof = lab['prof']
                    <td data-order="{{ ' '.join(reversed(prof['name'])) }}" class="dt-nowrap">
                        <a href="mailto:{{ prof['email'] }}">{{ ' '.join(prof['name']) }}</a>
                    </td>
                </tr>
                % end
            </tbody>
            <tfoot>
                <tr>
                    <th>Lab Projects</th>
                    <th>Official Lab Page</th>
                    <th>Professor</th>
                </tr>
            </tfoot>
        </table>
    </div>
</body>
