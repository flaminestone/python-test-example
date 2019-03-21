<script type="text/javascript" src="{{editor_url}}/web-apps/apps/api/documents/api.js"></script>


<select id="user_selector" onchange="pick_user()">
    <option value="1" selected="selected">Valera</option>
    <option value="2">Ivan</option>
    <option value="3">Stepasha</option>
    <option value="4">Vasek</option>
</select>
<p id="demo"></p>
%for file in sample_files:
<div>
    <span>{{file}}</span>
    <button onclick="view('{{file}}')">view</button>
    <button onclick="edit('{{file}}')">edit</button>
</div>
% end
<div id="editor"></div>


<script>
    let editor;

    pick_user();

    function view(filename) {
        if (editor) {
            editor.destroyEditor()
        }
        const filepath = 'files/' + filename;
        editor = new DocsAPI.DocEditor("editor",
            {
                documentType: get_file_type(filepath),
                document: {
                    url: "{{host_url}}" + '/' + filepath,
                    title: filename,
                    key: filename + '_key'
                },
                editorConfig: {mode: 'view',
                    user: {
                        id: this.current_user_id,
                        name: this.current_user_name
                    }
                }
            });
    }

    function edit(filename) {
        const filepath = 'files/' + filename;
        if (editor) {
            editor.destroyEditor()
        }
        editor = new DocsAPI.DocEditor("editor",
            {
                documentType: get_file_type(filepath),
                document: {
                    url: "{{host_url}}" + '/' + filepath,
                    title: filename,
                    key: filename + '_key'
                },
                editorConfig: {
                    mode: 'edit',
                    callbackUrl: "{{host_url}}" + '/callback' + '?filename=' + filename,
                    user: {
                        id: this.current_user_id,
                        name: this.current_user_name
                    }
                }
            });
    }

    function get_file_type(filename) {

        if (/docx$/.exec(filename)) {
            return "text"
        }
        if (/xlsx$/.exec(filename)) {
            return "spreadsheet"
        }
        if (/pptx$/.exec(filename)) {
            return "presentation"
        }
    }

    function pick_user() {
        const user_selector = document.getElementById("user_selector");
        this.current_user_name = user_selector.options[user_selector.selectedIndex].text;
        this.current_user_id = user_selector.options[user_selector.selectedIndex].value;
    }
</script>